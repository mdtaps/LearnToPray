//
//  Category+CoreDataProperties.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/30/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var prayer: NSSet?

}

// MARK: Generated accessors for prayer
extension Category {

    @objc(addPrayerObject:)
    @NSManaged public func addToPrayer(_ value: Prayer)

    @objc(removePrayerObject:)
    @NSManaged public func removeFromPrayer(_ value: Prayer)

    @objc(addPrayer:)
    @NSManaged public func addToPrayer(_ values: NSSet)

    @objc(removePrayer:)
    @NSManaged public func removeFromPrayer(_ values: NSSet)

}
