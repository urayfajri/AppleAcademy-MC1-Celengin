//
//  Income+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 31/03/22.
//
//

import Foundation
import CoreData


extension Income {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var add_notes: String?
    @NSManaged public var amount: Int64
    @NSManaged public var source: String?
    @NSManaged public var transaction: Transaction?

}

extension Income : Identifiable {

}
