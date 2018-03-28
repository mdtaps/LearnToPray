//
//  PrayerDetailsViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/10/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

class PrayerDetailsViewController: CoreDataViewController, DetailsListDelegate {
    
    fileprivate var detailsListViewController: DetailsContainerViewController?
    
    var prayer: Prayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildViewControllers()
        setupFetchedResultsController()
        
    }
    
    @IBAction func prayingButtonPressed(_ sender: UIButton) {
        launchPrayerTime()
        
    }
    
    func completePrayerTimeLaunch() {
        let prayerTimeVC = PrayerTimeViewController(nibName: "PrayerTimeViewController", bundle: nil)
        prayerTimeVC.delegate = self
        present(prayerTimeVC, animated: true) {
            self.navigationController?.popToRootViewController(animated: false)
        }
        
    }
    
    //Set Timer Length
    private func launchPrayerTime() {
        let timePickerVC = TimePickerViewController(nibName: "TimePickerViewController", bundle: nil)
        timePickerVC.modalPresentationStyle = .overCurrentContext
        timePickerVC.completion = completePrayerTimeLaunch
        present(timePickerVC, animated: true, completion: nil)
        
    }
}

extension PrayerDetailsViewController {
    fileprivate func setupChildViewControllers() {
        guard let detailsListViewController = childViewControllers.first as? DetailsContainerViewController else {
            fatalError("Check storyboard for missing DetailsContainerViewController")
            
        }
        self.detailsListViewController = detailsListViewController
        self.detailsListViewController?.delegate = self
        
    }
    
    fileprivate func setupFetchedResultsController() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Details.fetchRequest()
        
        var descriptors = [NSSortDescriptor]()
        descriptors.append(NSSortDescriptor(key: "dateAdded", ascending: true))
        
        let predicate = NSPredicate(format: "prayer = %@", argumentArray: [prayer as Any])
        
        fetchRequest.sortDescriptors = descriptors
        fetchRequest.predicate = predicate
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
}
