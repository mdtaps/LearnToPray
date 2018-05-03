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
    @IBOutlet weak var progressBarView: UIProgressView!
    
    var prayerDetailLabel = UILabel()
    var progress = Progress()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func pauseButtonPressed() {
        PrayerTimer.toggleTimer()
        pauseTimerButton.setTitle(PrayerTimer.timerState.rawValue, for: .normal)
        
    }
    
    @IBAction func finishButtonPressed() {
        PrayerTimer.stop()
        Audio.stopChimes()
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func rightButtonPressed() {
        
        progress.increment()
        
        //Get detail at current progress count
        guard let detail = delegate?.fetchedResultsController?.object(at: IndexPath(row: progress.count, section: 0)) as? Details else {
            print("Failed to get detail from row \(progress.count) FRC in PrayerTimeVC")
            return
            
        }
        
        updateLabels(with: detail)
        updateButtons()
        progressBarView.setProgress(progress.fractionComplete, animated: true)

    }
    
    @IBAction func leftButtonPressed() {
        
        progress.decrement()
        
        //Get detail at current progress count
        guard let detail = delegate?.fetchedResultsController?.object(at: IndexPath(row: progress.count, section: 0)) as? Details else {
            print("Failed to get detail from row \(progress.count) FRC in PrayerTimeVC")
            return
            
        }
        
        updateLabels(with: detail)
        updateButtons()
        progressBarView.setProgress(progress.fractionComplete, animated: true)

    }
    
}

extension PrayerTimeViewController {
    
    fileprivate func setUpLabels() {
        //Get first detail from FRC
        guard let detail =
            delegate?.fetchedResultsController?.object(at: IndexPath(row: 0, section: 0)) as? Details else {
                return
                
                }
        
        prayerTitleLabel.text = detail.prayer?.name
        prayerDetailTitleLabel.text = detail.title
        prayerDetailTextLabel.text = detail.text
        
        //Set the max progress as the amount of Prayer Detail objects (minus one, for 0 index)
        if let count = delegate?.fetchedResultsController?.fetchedObjects?.count {
            progress.max = count - 1
            
        }
        
    }
    
    private func setupTimerLabel() {
        prayerTimerLabel.text = timeString(time: TimeInterval(PrayerTimer.timePraying))
        pauseTimerButton.setTitle(PrayerTimer.timerState.rawValue, for: .normal)
        
    }
    
    private func setUpButtons() {
        if let objectsCount = delegate?.fetchedResultsController?.fetchedObjects?.count {
            //Set value that button becomes disabled as the number of prayer detail objects (minus one, for 0 index)
            prayerForwardButton.disableValue = objectsCount - 1
            
        }
        
        //If no delegate is set to display prayer details text, hide forward/back buttons and progress bar
        if delegate == nil {
            prayerBackButton.isHidden = true
            prayerForwardButton.isHidden = true
            progressBarView.isHidden = true
        }
    }
    
    //Hide/show buttons based on current progress through prayer details
    private func updateButtons() {
        prayerBackButton.setStatusFor(currentValueOf: progress.count)
        prayerForwardButton.setStatusFor(currentValueOf: progress.count)
        
    }
    
    //Update labels with new text
    private func updateLabels(with detail: Details) {
        prayerDetailTitleLabel.fadeInFadeOutWith(text: detail.title!)
        prayerDetailTextLabel.fadeInFadeOutWith(text: detail.text!)
        
    }
    
}

extension PrayerTimeViewController: TimerDelegate {
    func timerCounterDidUpdate() {
                prayerTimerLabel.text = timeString(time: PrayerTimer.timeLeftPraying)
    }
    
}
