//
//  PeopleGroupsViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/20/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import MapKit

class PeopleGroupsViewController: UIViewController {
    @IBOutlet weak var peopleGroupNameLabel: UILabel!
    @IBOutlet weak var peopleGroupImage: UIImageView!
    @IBOutlet weak var peopleGroupPopulation: UILabel!
    @IBOutlet weak var peopleGroupsMapView: MKMapView!
    @IBOutlet weak var peopleGroupsReligion: UILabel!
    
    var joshuaProjectObject: JoshuaProjectObject?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setMapRegion()
        
        title = "People Groups"
    }
}

extension PeopleGroupsViewController {
    private func setupView() {
        guard let data = joshuaProjectObject?.data?.first else {
            fatalError("Could not get data from Joshua Project Object")
        }
        
        self.peopleGroupNameLabel.text = data.peopleNameInCountry
        self.peopleGroupImage.image = UIImage(fromUrl: data.photoAddress)
        self.peopleGroupPopulation.text = "Population: \(data.worldPopulation)"
        self.peopleGroupsReligion.text = "Primary Religion: \(data.primaryReligion)"
        let mapPin = MapPin(latitude: data.latitude, longitude: data.longitude)
        self.peopleGroupsMapView.addAnnotation(mapPin)
    }
    
    private func setMapRegion() {
        let span = MKCoordinateSpanMake(25, 25)
        let region = MKCoordinateRegion(center: peopleGroupsMapView.annotations.first!.coordinate, span: span)
        
        //Set region for map view
        peopleGroupsMapView.setRegion(region, animated: false)
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
