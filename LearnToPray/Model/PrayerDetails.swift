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
    var detailsTitleArray = [String]()
    var detailsTextArray = [String]()
    var arrayPosition = 0
    
    var title: String {
        return self.detailsTitleArray[self.arrayPosition]
    }
    
    var text: String {
        return self.detailsTextArray[self.arrayPosition]
    }
    
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
            detailsTitleArray.append(detail.title!)
            //TODO: Fix detail.text
            detailsTextArray.append(detail.text!)
        }
    }
}
