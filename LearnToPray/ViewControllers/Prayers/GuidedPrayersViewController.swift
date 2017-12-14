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
        
        vc.prayer = prayer
        show(vc, sender: self)
        
    }
    
    private func setupChildViewControllers() {
        guard let prayersListViewController = childViewControllers.first as? PrayersListContainerViewController else {
            fatalError("Check storyboard for missing PrayersListContainerViewController")
        }
        
        self.prayersListViewController = prayersListViewController
        self.prayersListViewController?.delegate = self
        
    }
}
