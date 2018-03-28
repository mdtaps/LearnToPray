//
//  PrayerTimeViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/24/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

class PrayerTimeViewController: CoreDataViewController {
    @IBOutlet weak var prayerTitleLabel: UILabel!
    @IBOutlet weak var prayerTimeStackView: UIStackView!
    @IBOutlet weak var prayerTimerLabel: UILabel!
    @IBOutlet weak var pauseTimerButton: UIButton!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var prayerDetailTitleLabel: UILabel!
    @IBOutlet weak var prayerDetailTextLabel: UILabel!
    @IBOutlet weak var prayerBackButton: NextButton!
    @IBOutlet weak var prayerForwardButton: NextButton!
    
    var prayerDetailLabel = UILabel()
    var row = 0 {
        didSet {
            updateButtons()
        }
    }
    
    //Delegate for FRC and chosen Prayer object
    var delegate: DetailsListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PrayerTimer.delegate = self
        PrayerTimer.start()
        
        setupTimerLabel()
        setUpLabels()
        setUpButtons()
        
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
        
        guard let objectsCount = delegate?.fetchedResultsController?.fetchedObjects?.count,
            row < objectsCount - 1 else {
            return
        }
        
        row += 1
        
        guard let detail = delegate?.fetchedResultsController?.object(at: IndexPath(row: row, section: 0)) as? Details else {
            print("Failed to get detail from row \(row) FRC in PrayerTimeVC")
            return
        }
        prayerDetailTitleLabel.fadeInFadeOutWith(text: detail.title!)
        prayerDetailTextLabel.fadeInFadeOutWith(text: detail.text!)
    }
    
    @IBAction func leftButtonPressed() {
        guard row > 0 else {
            return
        }
        
        row -= 1
        
        guard let detail = delegate?.fetchedResultsController?.object(at: IndexPath(row: row, section: 0)) as? Details else {
            print("Failed to get detail from row \(row) FRC in PrayerTimeVC")
            return
        }
        prayerDetailTitleLabel.fadeInFadeOutWith(text: detail.title!)
        prayerDetailTextLabel.fadeInFadeOutWith(text: detail.text!)
        
    }
}

extension PrayerTimeViewController {
    
    fileprivate func setUpLabels() {
        guard let detail =
            delegate?.fetchedResultsController?.object(at: IndexPath(row: 0, section: 0)) as? Details else {
                return
                }
        prayerTitleLabel.text = detail.prayer?.name
        prayerDetailTitleLabel.text = detail.title
        prayerDetailTextLabel.text = detail.text
        
    }
    
    private func setupTimerLabel() {
        prayerTimerLabel.text = timeString(time: TimeInterval(PrayerTimer.timerCounter))
        pauseTimerButton.setTitle(PrayerTimer.timerState.rawValue, for: .normal)
        
    }
    
    private func setUpButtons() {
        if let objectsCount = delegate?.fetchedResultsController?.fetchedObjects?.count {
            prayerForwardButton.disableValue = objectsCount - 1
            
        }
        
        if delegate == nil {
            prayerBackButton.isHidden = true
            prayerForwardButton.isHidden = true
        }
    }
    
    private func updateButtons() {
        prayerBackButton.setStatusFor(currentValueOf: row)
        prayerForwardButton.setStatusFor(currentValueOf: row)
        
    }
}

extension PrayerTimeViewController: TimerDelegate {
    func timerCounterDidUpdate() {
        prayerTimerLabel.text = timeString(time: TimeInterval(PrayerTimer.timerCounter))
        
    }
}
