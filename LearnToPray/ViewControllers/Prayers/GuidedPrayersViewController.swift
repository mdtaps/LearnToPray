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
        
        var data: JoshuaProjectObject.JoshuaProjectData?
        
        if prayer.name == "People Groups" {
            JoshuaProjectClient.shared.retreivePeopleGroupOfTheDay { (joshuaProjectResponse) in
                switch joshuaProjectResponse {
                    
                case .Failure(let failureString):
                    //TODO: Show error
                    fatalError(failureString)
        
                case .Success(let response):
                    data = response.data!.first!
                }
            }
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PeopleGroupsViewController") as? PeopleGroupsViewController else {
                fatalError("Check stroyboard for missing PeopleGroupsViewController")
            }
            
            //TODO: Make sure data is returned from network call before making this call. Maybe send a data object to the next vc? Or make the call in viewdidload?
            vc.peopleGroupNameLabel.text = data?.peopleNameInCountry
            do {
                            vc.peopleGroupImage.image = try UIImage(data: Data(contentsOf: URL(string: data!.photoAddress!)!))
            } catch {
                print(error)
            }
            
            show(vc, sender: self)

            
        } else {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "PrayerDetailsViewController") as? PrayerDetailsViewController else {
                fatalError("Check storyboard for missing PrayerDetailsViewController")
            }
            
            vc.prayer = prayer
            show(vc, sender: self)
        }
    }
    
    private func setupChildViewControllers() {
        guard let prayersListViewController = childViewControllers.first as? PrayersListContainerViewController else {
            fatalError("Check storyboard for missing PrayersListContainerViewController")
        }
        
        self.prayersListViewController = prayersListViewController
        self.prayersListViewController?.delegate = self
        
    }
}
