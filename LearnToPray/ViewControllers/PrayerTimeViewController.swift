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
    @IBOutlet weak var prayerDetailLabel: UILabel!
    @IBOutlet weak var prayerTimerLabel: UILabel!
    
    var prayerDetails: PrayerDetails?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let prayerDetails = prayerDetails else {
            print("Failure to get prayerDetails in PrayerTimeViewController")
            return
        }
        
        prayerTitleLabel.text = prayerDetails.prayerName
        prayerDetailLabel.text = prayerDetails.detailsArray.first!
        prayerDetailLabel.backgroundColor = .red
    }
    
    //TODO: Figure out how to remove space on new label
    @IBAction func leftButtonPressed() {
        let label = prayerDetailLabel.createLabelOnRight()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "From Right"
        label.backgroundColor = .blue
        label.textColor = .white
        
        self.view.addSubview(label)
        self.view.bringSubview(toFront: label)
        shiftLeft(label: label)
    }
    
    func rightButtonPressed() {
//        createUILabelOnLeft()
//        shiftRight()
    }
    
    func setupLabel() {
        
    }
    
    func shiftLeft(label: UILabel) {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            let labelOriginEndPosition = CGPoint(x: 0.0, y: label.frame.minY)
            label.frame.origin = labelOriginEndPosition
            
        }, completion: { finished in
            print("Animation complete")
        })
    }
    
}
