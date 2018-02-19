//
//  LoadData.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/26/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

struct JSONPrayersList: Codable {
    let category: [JSONCategory]

    struct JSONCategory: Codable {
        var name: String
        var prayer: [JSONPrayer]
        
    }
    
    struct JSONPrayer: Codable {
        var name: String
        var text: String?
        var details: [JSONDetails]?
        
    }
    
    struct JSONDetails: Codable {
        var title: String?
        var text: String?
        
    }
    
}

