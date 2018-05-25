//
//  MapPin.swift
//  LearnToPray
//
//  Created by Mark Tapia on 5/24/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
    }
}
