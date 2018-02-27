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
    
    var presentingVC: UIViewController?
    var prayer: Prayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presentingVC = presentingViewController!
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func prayPressed(_ sender: UIButton) {
        PrayerTimer.timerCounter = Int(timePicker.countDownDuration)
        dismiss(animated: true) {
            let prayerTimeVC = PrayerTimeViewController(prayer: self.prayer)
            
            self.presentingVC!.present(prayerTimeVC, animated: true, completion: nil)
        }
    }
}
