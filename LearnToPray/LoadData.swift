//
//  LoadData.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/26/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

/*
func preloadData () {
    // Retrieve data from the source file
    if let contentsOfURL = Bundle.main.url(forResource: "PrayerList", withExtension: "json") {
        
        // Remove all the menu items before preloading
        removeData()
        
        var error: NSError?
        if let items = parseCSV(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error) {
            // Preload the menu items
            if let managedObjectContext = self.managedObjectContext {
                for item in items {
                    let menuItem = NSEntityDescription.insertNewObjectForEntityForName("MenuItem", inManagedObjectContext: managedObjectContext) as! MenuItem
                    menuItem.name = item.name
                    menuItem.detail = item.detail
                    menuItem.price = (item.price as NSString).doubleValue
                    
                    if managedObjectContext.save(&error) != true {
                        println("insert error: \(error!.localizedDescription)")
                    }
                }
            }
        }
    }
}

func removeData () {
    // Remove the existing items
    if let managedObjectContext = self.managedObjectContext {
        let fetchRequest = NSFetchRequest(entityName: "MenuItem")
        var e: NSError?
        let menuItems = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [MenuItem]
        
        if e != nil {
            println("Failed to retrieve record: \(e!.localizedDescription)")
            
        } else {
            
            for menuItem in menuItems {
                managedObjectContext.deleteObject(menuItem)
            }
        }
    }
}
 
*/

struct JSONPrayersList: Codable {
    let category: [JSONCategory]

    struct JSONCategory: Codable {
        var name: String
        var prayer: [JSONPrayer]
        
    }
    
    struct JSONPrayer: Codable {
        var name: String
        var text: String?
        var details: [JSONDetails]?
        
    }
    
    struct JSONDetails: Codable {
        var title: String
        var text: String?
        
    }
    
}

