//
//  Prayer+CoreDataProperties.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/11/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//
//

import Foundation
import CoreData


extension Prayer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prayer> {
        return NSFetchRequest<Prayer>(entityName: "Prayer")
    }

    @NSManaged public var name: String
    @NSManaged public var text: String?
    @NSManaged public var category: Category
    @NSManaged public var details: NSSet?

}

// MARK: Generated accessors for details
extension Prayer {

    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: Details)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: Details)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)

}
