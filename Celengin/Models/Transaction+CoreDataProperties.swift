//
//  Transaction+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 31/03/22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var id: Int64
    @NSManaged public var date: Date?
    @NSManaged public var is_income: Income?
    @NSManaged public var is_expense: Expense?
    @NSManaged public var goal: Goals?

}

extension Transaction : Identifiable {

}
