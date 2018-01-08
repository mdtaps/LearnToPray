//
//  PrayerDetails.swift
//  LearnToPray
//
//  Created by Mark Tapia on 1/4/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct PrayerDetails {
    var prayerName: String
    var detailsArray: [String]
    
    init(prayer: Prayer) {
        prayerName = prayer.name
        detailsArray = detailsFrom(prayer: prayer)
    }
}

func detailsFrom(prayer: Prayer) -> [String] {
        
    guard let details = prayer.details else {
        fatalError("Prayer has no details in PrayerDetails")
    }
    
    var array = [String]()
    
    for detail in details {
        guard let detail = detail as? Details else {
            fatalError("Cannot get data from prayer detail")
        }
        
        array.append(detail.title!)
    }
    
    return array
}
