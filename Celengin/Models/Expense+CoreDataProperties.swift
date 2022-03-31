//
//  Expense+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 31/03/22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var amount: Int64
    @NSManaged public var add_notes: String?
    @NSManaged public var needs: String?
    @NSManaged public var transaction: Transaction?

}

extension Expense : Identifiable {

}
