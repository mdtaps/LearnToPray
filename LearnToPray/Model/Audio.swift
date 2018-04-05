//
//  Audio.swift
//  LearnToPray
//
//  Created by Mark Tapia on 4/4/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import AVFoundation

struct Audio {
    static var Player: AVAudioPlayer?
    
    static func PlayChimes() {
        guard let url = Bundle.main.url(forResource: "chimes", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            Player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = Player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
            
        }
        
    }
    
    static func StopChimes() {
        guard let Player = Player else { return }
        Player.stop()
        
    }
    
}
