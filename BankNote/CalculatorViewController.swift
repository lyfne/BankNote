//
//  CalculatorViewController.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/7/26.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var m_parentVC: NewNoteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setParentVC(parent: NewNoteViewController) {
        m_parentVC = parent
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        m_parentVC?.getCharFromKeyboard(str: (sender.titleLabel?.text)!)
    }
    
    @IBAction func resetToZero(_ sender: Any) {
        m_parentVC?.resetToZero()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
