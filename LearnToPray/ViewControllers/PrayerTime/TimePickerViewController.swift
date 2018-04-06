//
//  TimePickerViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/19/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    var completion: (() -> ())?
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func prayPressed(_ sender: UIButton) {
        PrayerTimer.timerCounter = Int(timePicker.countDownDuration)
        dismiss(animated: true) {
            if let completion = self.completion {
                completion()
                
            }
            
        }
        
    }
    
}
