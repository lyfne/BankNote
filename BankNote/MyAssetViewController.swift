//
//  MyAssetViewController.swift
//  BankNote
//
//  Created by 林逸凡 on 2017/9/10.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import UIKit
import CoreData

class MyAssetViewController: UIViewController {

    @IBOutlet weak var assetTextField: UITextField!
    let m_assetManager = AssetManager.defaultManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let asset = m_assetManager.getTotalAsset()
        assetTextField.text = "\(asset)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAsset(_ sender: Any) {
        let doubleValue = Double(assetTextField.text!)!.roundTo(places: 2)
        m_assetManager.setTotalAsset(asset: doubleValue)
        
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
