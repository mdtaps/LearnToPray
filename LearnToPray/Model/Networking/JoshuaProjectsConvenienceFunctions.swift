//
//  JoshuaProjectsConvenienceFunctions.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/17/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation
import MapKit

extension JoshuaProjectClient {
    
    func retreivePeopleGroupOfTheDay(_ completionHandler: @escaping (_ response: Result<JoshuaProjectObject>) -> Void) {
        
        JoshuaProjectClient.shared.jpGETRequest { (dataTaskResult) in
            switch dataTaskResult {
            case .Failure(let failureString):
                completionHandler(.Failure(with: failureString))
            case .Success(let data):
                self.parseJoshuaProject(jsonData: data) { (jsonParsingResult) in
                    switch jsonParsingResult {
                    case .Failure(let failureString):
                        completionHandler(.Failure(with: failureString))
                    case .Success(let joshuaProjectObject):
                        completionHandler(.Success(with: joshuaProjectObject))
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    private func parseJoshuaProject(jsonData: Data, _ completionHandler: @escaping (Result<JoshuaProjectObject>) -> Void) {
        
        let decoder = JSONDecoder()
        
        do {
            let joshuaProjectObject = try decoder.decode(JoshuaProjectObject.self, from: jsonData)
            completionHandler(.Success(with: joshuaProjectObject))
            
        } catch {
            completionHandler(.Failure(with: error.localizedDescription))
            
        }
        
    }
    
}

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
