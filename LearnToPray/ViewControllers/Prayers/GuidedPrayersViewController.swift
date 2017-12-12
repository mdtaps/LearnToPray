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
    
    fileprivate var prayersListViewController: PrayersListContainerViewController?
    
    override func viewDidLoad() {
        
        setupChildViewControllers()
    }
    
    func didSelectPrayer(prayer: Prayer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PrayerDetailsViewController") as? PrayerDetailsViewController else {
            fatalError("Check storyboard for missing PrayerDetailsViewController")
        }
        
        //Create fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Details.fetchRequest()
        
        //Add sort descriptors
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        let predicate = NSPredicate(format: "prayer = %@", argumentArray: [prayer])
        fetchRequest.predicate = predicate
        
        let frController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        vc.prayer = prayer
        
        
    }
    
    private func setupChildViewControllers() {
        guard let prayersListViewController = childViewControllers.first as? PrayersListContainerViewController else {
            fatalError("Check storyboard for missing PrayersListContainerViewController")
        }
        
        self.prayersListViewController = prayersListViewController
        self.prayersListViewController?.delegate = self
        
    }
}
