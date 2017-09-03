//
//  Note.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/8/11.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import CoreData
import Foundation

class Note: NSManagedObject {
    @NSManaged var date: Date
    @NSManaged var is_income: Bool
    @NSManaged var type: String
    @NSManaged var amount: Double
}
