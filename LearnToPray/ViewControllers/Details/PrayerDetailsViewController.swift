//
//  PrayerDetailsViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/10/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit

class PrayerDetailsViewController: UIViewController, DetailsListDelegate {
    
    fileprivate var detailsViewController: DetailsContainerViewController?
    
    var prayer: Prayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupChildViewControllers() {
        guard let detailsViewController = childViewControllers.first as? DetailsContainerViewController else {
            fatalError("Check storyboard for missing DetailsContainerViewController")
        }
        
        self.detailsViewController = detailsViewController
        self.detailsViewController?.delegate = self
        
    }
}
