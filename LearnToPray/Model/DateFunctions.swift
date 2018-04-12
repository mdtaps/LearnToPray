//
//  DateFunctions.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/16/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import Foundation

func monthOfTodayAsInt() -> Int {
    let today = Calendar.current
    return today.component(.month, from: Date())
    
}

func dayOfTodayAsInt() -> Int {
    let today = Calendar.current
    return today.component(.day, from: Date())
    
}

//Function edited from https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
func timeString(time:TimeInterval) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format: "%02i:%02i", minutes, seconds)
    
}

