//
//  Prayer+CoreDataProperties.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/3/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//
//

import Foundation
import CoreData


extension Prayer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prayer> {
        return NSFetchRequest<Prayer>(entityName: "Prayer")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String
    @NSManaged public var text: String?
    @NSManaged public var category: Category?
    @NSManaged public var details: Details?

}
