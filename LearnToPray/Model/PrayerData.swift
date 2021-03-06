//
//  Parsing.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/30/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

struct PrayerData {
    static var data = Data()
    
    static func setData() {
        if let url = Bundle.main.url(forResource: "PrayerList", withExtension: "json") {
            do {
                data = try Data(contentsOf: url, options: .mappedIfSafe)
                
            } catch {
                print("URL Error")
                print(error)
                
            }
            
        }
        
    }
    
    static func parseJSON(completionHandler: @escaping(JSONPrayersList?, Error?) -> Void) {
        let decoder = JSONDecoder()
        do {
            let prayerList = try decoder.decode(JSONPrayersList.self, from: data)
            completionHandler(prayerList, nil)
            
        } catch {
            completionHandler(nil, error)
            
        }
        
    }
    
}
