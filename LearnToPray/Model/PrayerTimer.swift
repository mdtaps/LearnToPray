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
    static var timerCounter: Int = 65 {
        didSet {
            if timerCounter < 0 {
                timer.invalidate()
                Audio.PlayChimes()
            } else {
                delegate?.timerCounterDidUpdate()
            }
        }
    }
    static var timer = Timer()
    static var timerState: TimerState = .Running
    static var delegate: TimerDelegate?
}

extension PrayerTimer {
    enum TimerState: String {
        case Running = "Pause"
        case Paused = "Resume"
    }
    
    static func start() {
        PrayerTimer.timerState = .Running
        PrayerTimer.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            PrayerTimer.timerCounter -= 1 }
    }
    
    static func stop() {
        PrayerTimer.pause()
        PrayerTimer.timerCounter = 0
    }
    
    static func pause() {
        PrayerTimer.timerState = .Paused
        PrayerTimer.timer.invalidate()
    }
    
    static func toggleTimer() {
        switch PrayerTimer.timerState {
        case .Running:
            pause()
        case .Paused:
            start()
        }
    }
}
