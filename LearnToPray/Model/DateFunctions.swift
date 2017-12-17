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

