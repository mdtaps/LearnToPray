//
//  GuidedPrayersViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/10/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

class GuidedPrayersViewController: CoreDataViewController, PrayersListDelegate {
    
    func didSelectPrayer(prayerName: String) {
        
        //Create fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Prayer.fetchRequest()
        
        //Add sort descriptors
        var descriptors = [NSSortDescriptor]()
        descriptors.append(NSSortDescriptor(key: "name", ascending: true))
        
        fetchRequest.sortDescriptors = descriptors
        
        let predicate = NSPredicate(format: "name = %@", argumentArray: [prayerName])
        fetchRequest.predicate = predicate
        
        let frController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        dump(frController.fetchedObjects)
        
    }
}
