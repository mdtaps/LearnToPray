//
//  UserDefaultsManager.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/11/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    private static let hasLaunchedPreviouslyKey = "hasLaunchedPreviouslyKey"
    
    static var hasLaunchedPreviously: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasLaunchedPreviouslyKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLaunchedPreviouslyKey)
        }
    }
}
