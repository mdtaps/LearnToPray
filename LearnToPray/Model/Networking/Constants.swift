//
//  Constants.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/15/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

struct JoshuaProjectAPIConstants {
    struct URLComponents {
        static let Scheme = "https"
        static let Host = "joshuaproject.net"
        static let Path = "/api/v2/upgotd"
    }
    
    struct URLQueryKey {
        static let APIKey = "api_key"
        static let ROL3Profile = "ROL3Profile"
        static let LRofTheDayMonth = "LRofTheDayMonth"
        static let LRofTheDayDay = "LRofTheDayDay"
    }
    
    struct URLQueryValue {
        static let ROL3Profile = "eng"
        static let APIKey = getAPIKey()
    }
    
    private static func getAPIKey() -> String {
        guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            fatalError("Check file list for APIKey.plist")
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: filePath) as? [String : String] else {
            fatalError("Could not get contents of file: \(filePath)")
        }
        
        guard let apiKey = dictionary["apiKey"] else {
            fatalError("No value for key \"apiKey\"")
        }
        
        return apiKey
    }
}

struct MailComponentConstants {
    static let ToRecipients = ["contactlearntopray@gmail.com"]
}

struct URLConstants {
    static let LearnToPrayAppStoreUrl = "itms-apps://itunes.apple.com/app/id1370306129"
}
