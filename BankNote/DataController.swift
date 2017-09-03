//
//  DataController.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/8/11.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    var m_managedObjectContext: NSManagedObjectContext
    
    override init() {
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.m_managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.m_managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let docURL = urls[urls.endIndex-1]
        let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        
    }
}
