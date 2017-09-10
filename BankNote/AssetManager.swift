//
//  AssetManager.swift
//  BankNote
//
//  Created by 林逸凡 on 2017/9/10.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import UIKit
import CoreData

class AssetManager: NSObject {
    static let defaultManager = AssetManager()
    let m_context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var totals: [Total] = []
    
    private override init() {
        super.init()
    }
    
    func loadTotalAsset() {
        do {
            totals = try m_context.fetch(Total.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func getTotalAsset()->Double {
        loadTotalAsset()
        if totals.isEmpty {
            let total = Total(context: m_context)
            total.amount = 0
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        loadTotalAsset()
        
        return totals[0].amount
    }
    
    func setTotalAsset(asset: Double) {
        if totals.isEmpty {
            return
        }
        
        totals[0].amount = asset
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
