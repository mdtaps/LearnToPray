//
//  PrayerDetails.swift
//  LearnToPray
//
//  Created by Mark Tapia on 1/4/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct PrayerDetails {
    var prayer: Prayer?
    var detailsArray = [String]()
    var arrayPosition = 0
    
    init() { }
    
    init(prayer: Prayer) {
        self.prayer = prayer
        populateDetailsArray()
    }
    
    private mutating func populateDetailsArray() {
        guard let details = prayer?.details as? Set<Details> else {
            print("No details in prayer object")
            return
        }
        
        for detail in details {
            detailsArray.append(detail.title!)
        }
    }
}
