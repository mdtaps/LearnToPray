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
    
    fileprivate var prayersListViewController: PrayersListContainerViewController?

    override func viewDidLoad() {
        setupChildViewControllers()
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    func didSelectPrayer(prayer: Prayer) {
        if prayer.name == "People Groups" {
            JoshuaProjectClient.shared.retreivePeopleGroupOfTheDay { (joshuaProjectResponse) in
                switch joshuaProjectResponse {
                    
                case .Failure(let failureString):
                    //TODO: Show error
                    fatalError(failureString)
        
                case .Success(let response):
                    DispatchQueue.main.async {
                        self.launchPeopleGroupViewController(response)

                    }
                }
            }
            
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
        
        vc.peopleGroupNameLabel.text = data.peopleNameInCountry
        print(data.photoAddress)
        vc.peopleGroupImage.image = getImage(from: data.photoAddress)
        vc.peopleGroupPopulation.text = "Population: \(data.worldPopulation)"
        let coordiante = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
        vc.peopleGroupsMapView.addAnnotation(MapPin(coordinate: coordiante))
        //TODO: Add coordinate to map
        
        show(vc, sender: self)
    }
    
    private func getImage(from urlString: String) -> UIImage {
        guard let url = URL(string: urlString) else {
            return UIImage()
        }
        
        let urlData: Data
        do {
            urlData = try Data(contentsOf: url)
        } catch {
            return UIImage()
        }
        
        guard let image = UIImage(data: urlData) else {
            return UIImage()
        }
        
        return image
    }
}

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate

    }
}
