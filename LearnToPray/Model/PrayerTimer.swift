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

struct PrayerTimer {
    static var timePraying: Double = 0 {
        didSet {
            endTime = Date().timeIntervalSince1970 + timePraying
        }
    }
    
    //For timer to run in the background, timer needs to
    //be based off Unix time stamp. I will need to run
    //have timer label string be based on time left
    //between current time and end time. I also need
    //to deal with the static variables
    
    
    static var timer = Timer()
    static var timerState: TimerState = .Running
    static var delegate: TimerDelegate?
    static var endTime = 0.0
    static var timeLeftPraying: Double {
        return (endTime - Date().timeIntervalSince1970)
    }
    private static var timeLeftWhilePaused = 0.0
    
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
        timeLeftWhilePaused = endTime - Date().timeIntervalSince1970
        timerState = .Paused
        timer.invalidate()
        
    }
    
    static func toggleTimer() {
        switch timerState {
        case .Running:
            pause()
        case .Paused:
            timePraying = timeLeftWhilePaused
            start()
            
        }
        
    }
    
    private static func timerDecrement() {
        if endTime < Date().timeIntervalSince1970 {
            timePraying = 0
            delegate?.timerCounterDidUpdate()
            timer.invalidate()
            Audio.playChimes()
        } else {
            delegate?.timerCounterDidUpdate()
            
        }
    }
    
}
