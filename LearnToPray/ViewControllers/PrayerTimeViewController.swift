//
//  PrayerTimeViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/24/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

class PrayerTimeViewController: UIViewController {
    @IBOutlet weak var prayerTitleLabel: UILabel!
    @IBOutlet weak var prayerTimeStackView: UIStackView!
    @IBOutlet weak var prayerTimerLabel: UILabel!
    @IBOutlet weak var pauseTimerButton: UIButton!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var prayerDetailTitleLabel: UILabel!
    @IBOutlet weak var prayerDetailTextLabel: UILabel!
    
    
    var prayerDetails: PrayerDetails
    var prayerDetailLabel = UILabel()
    
    init(prayer: Prayer?) {
        if let prayer = prayer {
            self.prayerDetails = PrayerDetails(prayer: prayer)
            
        } else {
            self.prayerDetails = PrayerDetails()
            
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PrayerTimer.delegate = self
        PrayerTimer.start()
        
        setupTimerLabel()
        
        if let _ = prayerDetails.prayer {
            setUpLabels()
            
        }
    }
    
    @IBAction func pauseButtonPressed() {
        PrayerTimer.toggleTimer()
        pauseTimerButton.setTitle(PrayerTimer.timerState.rawValue, for: .normal)
        
    }
    
    @IBAction func finishButtonPressed() {
        PrayerTimer.stop()
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func rightButtonPressed() {
        guard prayerDetails.arrayPosition < prayerDetails.detailsTitleArray.count - 1 else {
            return
        }
        
        prayerDetails.arrayPosition += 1
        
        prayerDetailTitleLabel.fadeInFadeOutWith(text: prayerDetails.title)
        prayerDetailTextLabel.fadeInFadeOutWith(text: prayerDetails.text)

    }
    
    @IBAction func leftButtonPressed() {
        guard prayerDetails.arrayPosition > 0 else {
            return
        }
        
        prayerDetails.arrayPosition -= 1
        
        prayerDetailTitleLabel.fadeInFadeOutWith(text: prayerDetails.title)
        prayerDetailTextLabel.fadeInFadeOutWith(text: prayerDetails.text)
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
}

extension PrayerTimeViewController {
    
    fileprivate func setUpLabels() {
        prayerTitleLabel.text = prayerDetails.prayer?.name
        prayerDetailTitleLabel.text = prayerDetails.title
        prayerDetailTextLabel.text = prayerDetails.text
        
    }
    
    private func setupTimerLabel() {
        prayerTimerLabel.text = timeString(time: TimeInterval(PrayerTimer.timerCounter))
        pauseTimerButton.setTitle(PrayerTimer.timerState.rawValue, for: .normal)
        
    }
}

extension PrayerTimeViewController: TimerDelegate {
    func timerCounterDidUpdate() {
        prayerTimerLabel.text = timeString(time: TimeInterval(PrayerTimer.timerCounter))
        
    }
}
