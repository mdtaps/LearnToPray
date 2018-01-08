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
    }
}
