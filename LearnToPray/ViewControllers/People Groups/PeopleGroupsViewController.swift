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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setMapRegion()
    }
}

extension PeopleGroupsViewController {
    
    fileprivate func setMapRegion() {
        let span = MKCoordinateSpanMake(25, 25)
        let region = MKCoordinateRegion(center: peopleGroupsMapView.annotations.first!.coordinate, span: span)
        
        peopleGroupsMapView.setRegion(region, animated: false)
    }
}
