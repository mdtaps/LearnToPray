//
//  Progress.swift
//  LearnToPray
//
//  Created by Mark Tapia on 3/30/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct Progress {
    var count: Int = 0
    var max: Int = 0
    var fractionComplete: Float {
        return Float(count)/Float(max)
    }
    
    mutating func increment() {
        if count < max {
            self.count += 1

        }
        
    }
    
    mutating func decrement() {
        if count > 0 {
            self.count -= 1

        }
        
    }
}
