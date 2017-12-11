//
//  Details+CoreDataProperties.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/11/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//
//

import Foundation
import CoreData


extension Details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Details> {
        return NSFetchRequest<Details>(entityName: "Details")
    }

    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var prayer: Prayer?

}
