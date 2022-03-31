//
//  Goals+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 31/03/22.
//
//

import Foundation
import CoreData


extension Goals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goals> {
        return NSFetchRequest<Goals>(entityName: "Goals")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var target: Int64
    @NSManaged public var progress: Int64
    @NSManaged public var status: Bool
    @NSManaged public var deadline: Date?
    @NSManaged public var breakdown: String?
    @NSManaged public var add_notes: String?
    @NSManaged public var transaction: NSSet?
    @NSManaged public var user: User?

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
