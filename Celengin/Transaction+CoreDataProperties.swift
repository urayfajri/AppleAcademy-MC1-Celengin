//
//  Transaction+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 05/04/22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var date: Date?
    @NSManaged public var goal: Goals?
    @NSManaged public var is_expense: Expense?
    @NSManaged public var is_income: Income?

}

extension Transaction : Identifiable {

}
