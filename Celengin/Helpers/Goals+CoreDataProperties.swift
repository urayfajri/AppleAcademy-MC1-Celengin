//
//  Goals+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 11/04/22.
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
    @NSManaged public var progress: Double
    @NSManaged public var status: Bool
    @NSManaged public var target: Double
    @NSManaged public var transaction: NSSet?
    @NSManaged public var createdAt: Date?

}

// MARK: Generated accessors for transaction
extension Goals {

    @objc(addTransactionObject:)
    @NSManaged public func addToTransaction(_ value: Transaction)

    @objc(removeTransactionObject:)
    @NSManaged public func removeFromTransaction(_ value: Transaction)

    @objc(addTransaction:)
    @NSManaged public func addToTransaction(_ values: NSSet)

    @objc(removeTransaction:)
    @NSManaged public func removeFromTransaction(_ values: NSSet)

}

extension Goals : Identifiable {

}
