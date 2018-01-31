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
    @IBOutlet weak var prayerDetailPlaceHolderLabel: UILabel!
    @IBOutlet weak var prayerTimerLabel: UILabel!
    
    var prayerDetails: PrayerDetails
    var prayerDetailLabel = UILabel()
    var prayerTimer: PrayerTimer
    
    init(prayer: Prayer, timerLength: Int) {
        self.prayerDetails = PrayerDetails(prayer: prayer)
        self.prayerTimer = PrayerTimer(timerCounter: timerLength)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prayerTimer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prayerDetailLabel = UILabel(frame: prayerDetailPlaceHolderLabel.frame)
        prayerDetailLabel.applyPrayerDetailStyling()
        prayerTimeStackView.addSubview(prayerDetailLabel)
        
        prayerTitleLabel.text = prayerDetails.prayer.name
        prayerDetailLabel.text = prayerDetails.detailsArray.first ?? ""
        
        prayerTimerLabel.text = String(prayerTimer.timerCounter)
        prayerTimer.startPrayerTimer()
    }
    
    @IBAction func rightButtonPressed() {
        guard prayerDetails.arrayPosition < prayerDetails.detailsArray.count - 1 else {
            return
        }
        
        prayerDetails.arrayPosition += 1
        
        let newPrayerDetailLabel = prayerDetailLabel.createLabelOnRight()
        prayerTimeStackView.addSubview(newPrayerDetailLabel)
        newPrayerDetailLabel.text = prayerDetails.detailsArray[prayerDetails.arrayPosition]
        
        shiftLabelsLeft(label: newPrayerDetailLabel)
    }
    
    @IBAction func leftButtonPressed() {
        guard prayerDetails.arrayPosition > 0 else {
            return
        }
        
        prayerDetails.arrayPosition -= 1

        let newPrayerDetailLabel = prayerDetailLabel.createLabelOnLeft()
        prayerTimeStackView.addSubview(newPrayerDetailLabel)
        newPrayerDetailLabel.text = prayerDetails.detailsArray[prayerDetails.arrayPosition]
        
        shiftLabelsRight(label: newPrayerDetailLabel)
    }
}

extension PrayerTimeViewController {
    func shiftLabelsLeft(label: UILabel) {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            let newLabelOriginEndPosition = CGPoint(x: 0.0, y: label.frame.minY)
            let currentLabelOriginEndPosition = CGPoint(x: self.prayerDetailLabel.frame.minX - (self.prayerDetailLabel.frame.width),
                                                        y: self.prayerDetailLabel.frame.minY)
            
            self.view.layoutIfNeeded()
            self.prayerDetailLabel.frame.origin = currentLabelOriginEndPosition
            label.frame.origin = newLabelOriginEndPosition
            
        }, completion: { finished in
            if finished {
                self.prayerDetailLabel.removeFromSuperview()
                self.prayerDetailLabel = label
            }
        })
    }
    
    func shiftLabelsRight(label: UILabel) {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            let newLabelOriginEndPosition = CGPoint(x: 0.0,
                                                    y: label.frame.minY)
            let currentLabelOriginEndPosition = CGPoint(x: self.prayerDetailLabel.frame.width,
                                                        y: self.prayerDetailLabel.frame.minY)
            
            self.view.layoutIfNeeded()
            self.prayerDetailLabel.frame.origin = currentLabelOriginEndPosition
            label.frame.origin = newLabelOriginEndPosition
            
        }, completion: { finished in
            if finished {
                self.prayerDetailLabel.removeFromSuperview()
                self.prayerDetailLabel = label
            }
        })
    }
}

extension PrayerTimeViewController: TimerDelegate {
    func timerCounterDidUpdate() {
        prayerTimerLabel.text = String(prayerTimer.timerCounter)
    }
}
