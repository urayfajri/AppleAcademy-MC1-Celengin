//
//  Goals+CoreDataProperties.swift
//  Celengin
//
<<<<<<< HEAD
//  Created by Kathleen Febiola Susanto on 11/04/22.
=======
//  Created by Kathleen Febiola Susanto on 09/04/22.
>>>>>>> 4816fac (Transaction Record and Change Database)
//
//

import Foundation
import CoreData


extension Goals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goals> {
        return NSFetchRequest<Goals>(entityName: "Goals")
    }

    @NSManaged public var add_notes: String?
    @NSManaged public var breakdown: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var name: String?
    @NSManaged public var progress: Int64
    @NSManaged public var status: Bool
    @NSManaged public var target: Int64
    @NSManaged public var expenses: NSSet?
    @NSManaged public var incomes: NSSet?

}

// MARK: Generated accessors for expenses
extension Goals {

    @objc(addTransactionObject:)
    @NSManaged public func addToTransaction(_ value: Goals)

    @objc(removeTransactionObject:)
    @NSManaged public func removeFromTransaction(_ value: Goals)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

// MARK: Generated accessors for incomes
extension Goals {

    @objc(addIncomesObject:)
    @NSManaged public func addToIncomes(_ value: Income)

    @objc(removeIncomesObject:)
    @NSManaged public func removeFromIncomes(_ value: Income)

    @objc(addIncomes:)
    @NSManaged public func addToIncomes(_ values: NSSet)

    @objc(removeIncomes:)
    @NSManaged public func removeFromIncomes(_ values: NSSet)

}

extension Goals : Identifiable {

}
