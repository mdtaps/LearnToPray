//
//  GuidedPrayersViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/10/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class GuidedPrayersViewController: CoreDataViewController, PrayersListDelegate {
    
    var activityIndicator: UIActivityIndicatorView?
    
    fileprivate var prayersListViewController: PrayersListContainerViewController?

    override func viewDidLoad() {
        setupChildViewControllers()
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func didSelectPrayer(prayer: Prayer) {
        //If "People Groups" tapped, launch custom view controller
        if prayer.name == "People Groups" {
            //Show activity indicator while retrieving People Group data
           activityIndicator?.startAnimating()
            activityIndicator?.isHidden = false
            JoshuaProjectClient.shared.retreivePeopleGroupOfTheDay { (joshuaProjectResponse) in
                switch joshuaProjectResponse {
                    
                case .Failure(let failureString):
                    print(failureString)
                    let alert = UIAlertController(title: "Network Error", message: "Could not retreive People Group data", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    alert.addAction(dismiss)
                    
                    DispatchQueue.main.async {
                        self.present(alert, animated: true) {
                            self.activityIndicator?.isHidden = true
                            self.activityIndicator?.stopAnimating()
                            
                        }
                        
                    }
        
                case .Success(let response):
                    DispatchQueue.main.async {
                       self.activityIndicator?.stopAnimating()
                        self.launchPeopleGroupViewController(response)
                        
                    }
                    
                }
                
            }
            
        //Otherwise, launch Prayer Details VC
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

extension GuidedPrayersViewController {
    func launchPeopleGroupViewController(_ response: JoshuaProjectObject) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PeopleGroupsViewController") as? PeopleGroupsViewController else {
            fatalError("Check stroyboard for missing PeopleGroupsViewController")
            
        }
        
        let data = response.data!.first!
        //Called to get view to load
        let _ = vc.view
        
        //Set people group data
        vc.peopleGroupNameLabel.text = data.peopleNameInCountry
        vc.peopleGroupImage.image = UIImage(fromUrl: data.photoAddress)
        vc.peopleGroupPopulation.text = "Population: \(data.worldPopulation)"
        vc.peopleGroupsReligion.text = "Primary Religion: \(data.primaryReligion)"
        let coordiante = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
    vc.peopleGroupsMapView.addAnnotation(MapPin(coordinate: coordiante))
        
        show(vc, sender: self)
        
    }
    
}
