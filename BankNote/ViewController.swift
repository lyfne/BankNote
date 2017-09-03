//
//  ViewController.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/7/26.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var assetTextField: UITextField!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

