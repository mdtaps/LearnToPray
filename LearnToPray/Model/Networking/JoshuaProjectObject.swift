//
//  JoshuaProjectObject.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/18/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct JoshuaProjectObject: Codable {
    
    let data: [JoshuaProjectData]?
    
    struct JoshuaProjectData: Codable {
        let regionName: String
        let peopleNameInCountry: String
        let worldPopulation: Int
        let photoAddress: String
        let longitude: Double
        let latitude: Double
        let primaryReligion: String
        
        enum CodingKeys: String, CodingKey {
            case regionName = "RegionName"
            case peopleNameInCountry = "PeopNameInCountry"
            case worldPopulation = "WorldPopulation"
            case photoAddress = "PhotoAddress"
            case longitude = "Longitude"
            case latitude = "Latitude"
            case primaryReligion = "PrimaryReligion"
            
        }
    }
}
