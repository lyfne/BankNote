//
//  NewNoteViewController.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/7/26.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit
import CoreData

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

let InitialValue = -99999.9

class NewNoteViewController: UIViewController {

    let m_textScanner = TextScanner()
    let m_calculator = Calculator()
    var m_amount = InitialValue
    var m_isIncome = false
    var m_date: Date?
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCalculator()
        m_textScanner.setParentVC(parent: self)
        
        if m_isIncome {
            self.title = "New Income"
        }else {
            self.title = "New Expend"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stringToDouble(str:String)->Double {
        var output = 0.0
        output = Double(str)!
        return output
    }

    func initCalculator() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        controller.view.frame.origin.x = 0
        controller.view.frame.origin.y = 160;
        
        controller.setParentVC(parent: self)
    }
    
    func getCharFromKeyboard(str: String) {
        if !str.isEmpty {
            resultLabel.text = m_textScanner.inputChar(str: str)
        }
    }
    
    func resetToZero() {
        resultLabel.text = "0"
        m_textScanner.reset()
        m_calculator.reset()
    }
    
    func setParam1(str:String) {
        m_calculator.setParam(param: stringToDouble(str: str))
    }
    
    func setOperator(str:String) {
        m_calculator.setOperator(opt: str)
    }
    
    func setParam2(str:String) {
        m_calculator.setParam(param: stringToDouble(str: str))
        var result = m_calculator.equal()
        result = result.roundTo(places: 2)
        let isInteger = floor(result) == result
        
        if (isInteger) {
            var intResult = 0
            intResult = Int(result)
            
            m_textScanner.setResultAsParam1(result: "\(intResult)")
            m_calculator.setResultAsParam1(result: result)
            
            resultLabel.text = "\(intResult)"
        }else {
            m_textScanner.setResultAsParam1(result: "\(result)")
            m_calculator.setResultAsParam1(result: result)
            
            resultLabel.text = "\(result)"
        }
        m_amount = result
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        
        if m_amount == -99999.9 {
            m_amount = Double(resultLabel.text!)!
        }
        
        if m_amount <= 0 {
            return
        }
        
        if m_date == nil {
            m_date = Date()
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newNote = Note(context: context)
        newNote.is_income = m_isIncome
        newNote.type = "Food"
        newNote.date = m_date as NSDate?
        newNote.amount = m_amount
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        self.navigationController?.popViewController(animated: true)
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
