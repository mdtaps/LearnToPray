//
//  CoreDataViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/26/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            if let fc = fetchedResultsController {
                do {
                    try fc.performFetch()
                } catch let e as NSError {
                    print("Error while trying to perform a search: \n\(e)\n\(String(describing: fetchedResultsController))")
                }
            }
        }
    }
    
    
    //TODO: Sort by date added
    func createFetchedResultsController(for managedObject: NSManagedObject.Type, sortingBy descriptor: String? = nil) -> NSFetchedResultsController<NSFetchRequestResult> {
        
        //Create fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = managedObject.fetchRequest()
        
        //Add sort descriptors
        var descriptors = [NSSortDescriptor]()
        descriptors.append(NSSortDescriptor(key: "category.name", ascending: true))
        
        fetchRequest.sortDescriptors = descriptors
        
        //Return fetchedResultsController
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.stack.context, sectionNameKeyPath: "category.name", cacheName: nil)
        
    }
}

