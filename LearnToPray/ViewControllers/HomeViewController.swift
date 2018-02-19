//
//  HomeViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/16/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func guidedPrayerTapped() {
       launchGuidedPrayer()
    }
    
    @IBAction func startPrayingTapped() {
        launchPrayerTime()
    }
    
    @IBAction func donationTapped() {
        launchDonationVC()
    }
}

extension HomeViewController {
    
    private func launchPrayerTime() {
        let prayerTimeVC = PrayerTimeViewController(prayer: nil, timerLength: 300)
        present(prayerTimeVC, animated: true, completion: nil)
    }
    
    private func launchDonationVC() {
        let donationVC = DonationViewController(nibName: nil, bundle: nil)
        present(donationVC, animated: true, completion: nil)
    
    }
    private func launchGuidedPrayer() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        
        present(navigationController, animated: true, completion: nil)
    }

}
