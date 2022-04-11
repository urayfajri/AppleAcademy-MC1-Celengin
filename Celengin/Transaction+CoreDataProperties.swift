//
//  Transaction+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 11/04/22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var resources: String?
    @NSManaged public var type: String?
    @NSManaged public var goals: Goals?

}

extension Transaction : Identifiable {

}
