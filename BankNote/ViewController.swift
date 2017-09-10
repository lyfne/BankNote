//
//  ViewController.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/7/26.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit
import CoreData

let CellID = "NoteCell"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var bankNoteTableView: UITableView!
    
    let m_context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let m_assetManager = AssetManager.defaultManager
    var notes: [Note] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let asset = m_assetManager.getTotalAsset()
        assetLabel.text = "\(asset)"
        
        getData()
        bankNoteTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toVC = segue.destination as? NewNoteViewController {
            if segue.identifier == "toNewIncome" {
                toVC.m_isIncome = true
            }
            else if segue.identifier == "toNewExpend" {
                toVC.m_isIncome = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    func initTableView() {
        bankNoteTableView.delegate = self
        bankNoteTableView.dataSource = self
    }
    
    func getData() {
        do {
            notes = try m_context.fetch(Note.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: NoteCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: CellID) as? NoteCell
        
        if cell == nil {
            cell = NoteCell()
        }
        
        let note = notes[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: note.date! as Date)
        
        cell?.dateLabel.text = dateStr
        cell?.typeLabel.text = note.type
        cell?.amountLabel.text = "\(note.amount)"
        
        if note.is_income {
            cell?.backgroundColor = UIColor.green
        }else {
            cell?.backgroundColor = UIColor.red
        }
        
        return cell!
    }
}

