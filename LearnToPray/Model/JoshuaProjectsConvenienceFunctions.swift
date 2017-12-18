//
//  JoshuaProjectsConvenienceFunctions.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/17/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

extension JoshuaProjectClient {
    
    func retreivePeopleGroupOfTheDay(_ completionHandler: @escaping (_ response: Result<JoshuaProjectObject>) -> Void) {
        
        JoshuaProjectClient.shared.jpGETRequest { (dataTaskResult) in
            switch dataTaskResult {
            case .Failure(let failureString):
                completionHandler(.Failure(with: failureString))
            case .Success(let data):
                parseJoshuaProject(jsonData: data) { (jsonParsingResult) in
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
}

func parseJoshuaProject(jsonData: Data, _ completionHandler: @escaping (Result<JoshuaProjectObject>) -> Void) {
    let decoder = JSONDecoder()
    do {
        let joshuaProjectObject = try decoder.decode(JoshuaProjectObject.self, from: jsonData)
        completionHandler(.Success(with: joshuaProjectObject))
    } catch {
        completionHandler(.Failure(with: error.localizedDescription))
    }
}

struct JoshuaProjectObject: Codable {
    let longitude: Double
    let latitude: Double
    let photoAddress: String
    let peopNameInCountry: String
}
