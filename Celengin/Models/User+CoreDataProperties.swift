//
//  User+CoreDataProperties.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 31/03/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var goal: NSSet?

}

// MARK: Generated accessors for goal
extension User {

    @objc(addGoalObject:)
    @NSManaged public func addToGoal(_ value: Goals)

    @objc(removeGoalObject:)
    @NSManaged public func removeFromGoal(_ value: Goals)

    @objc(addGoal:)
    @NSManaged public func addToGoal(_ values: NSSet)

    @objc(removeGoal:)
    @NSManaged public func removeFromGoal(_ values: NSSet)

}

extension User : Identifiable {

}
