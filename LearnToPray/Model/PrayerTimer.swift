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
    var timerState: TimerState
    var delegate: TimerDelegate?
    
    init(timerCounter: Int) {
        self.timerCounter = timerCounter
        self.timerState = .Paused
    }
}

extension PrayerTimer {
    enum TimerState: String {
        case Running = "Pause"
        case Paused = "Resume"
    }
    
    func start() {
        timerState = .Running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.timerCounter -= 1 }
    }
    
    func stop() {
        timerState = .Paused
        timer.invalidate()
    }
    
    func toggleTimer() {
        switch timerState {
        case .Running:
            stop()
        case .Paused:
            start()
        }
    }
}
