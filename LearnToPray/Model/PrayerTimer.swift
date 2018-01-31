//
//  PrayerTimer.swift
//  LearnToPray
//
//  Created by Mark Tapia on 1/20/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import UIKit

protocol TimerDelegate {
    func timerCounterDidUpdate()
}

class PrayerTimer {
    var timerCounter: Int {
        didSet {
            if timerCounter < 1 {
                timer.invalidate()
            } else {
                delegate?.timerCounterDidUpdate()
            }
        }
    }
    var timer = Timer()
    var delegate: TimerDelegate?
    
    init(timerCounter: Int) {
        self.timerCounter = timerCounter
    }
    
    func startPrayerTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.timerCounter -= 1 }
    }
    
    func stopPrayerTimer() {
        timer.invalidate()
    }
    
    func pausePrayerTimer() {
        timer.invalidate()
    }
}
