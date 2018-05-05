//
//  PrayerTimer.swift
//  LearnToPray
//
//  Created by Mark Tapia on 1/20/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

protocol TimerDelegate {
    func timerCounterDidUpdate()
    
}

struct PrayerTimer {
    static var timePraying: Double = 0 {
        didSet {
            endTime = unixTime + timePraying
        }
    }
    
    static var unixTime: TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    static var timeLeftPraying: Double {
        return (endTime - unixTime)
    }
    
    static var timer = Timer()
    static var timerState: TimerState = .Running
    static var delegate: TimerDelegate?
    static var endTime = 0.0
    
}

extension PrayerTimer {
    enum TimerState: String {
        case Running = "Pause"
        case Paused = "Resume"
        
    }
    
    static func start() {
        timerState = .Running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timerDecrement()
            
        }
        
    }
    
    static func stop() {
        pause()
        PrayerTimer.timePraying = 0
        
    }
    
    static func pause() {
        timePraying = endTime - unixTime
        timerState = .Paused
        timer.invalidate()
        
    }
    
    static func toggleTimer() {
        switch timerState {
        case .Running:
            pause()
        case .Paused:
            endTime = timePraying + unixTime
            start()
            
        }
        
    }
    
    private static func timerDecrement() {
        if endTime < unixTime {
            stop()
            delegate?.timerCounterDidUpdate()
            timer.invalidate()
            Audio.playChimes()
        } else {
            delegate?.timerCounterDidUpdate()
            
        }
    }
    
}
