//
//  HomeViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/16/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let menuTransitioningDelegate = MenuTransitioningDelegate()
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func guidedPrayerTapped() {
       launchGuidedPrayer()
    }
    
    @IBAction func startPrayingTapped() {
        launchPrayerTime()
    }
    
    @IBAction func peopleGroupTapped() {
        launchPeopleGroupPrayer()
    }
    
    @IBAction func menuTapped() {
        launchMenu()
    }
}

extension HomeViewController {
    private func launchPrayerTime() {
        func completion() {
            let prayerTimeVC = PrayerTimeViewController(nibName: "PrayerTimeViewController", bundle: nil)
            present(prayerTimeVC, animated: true, completion: nil)
        }
        
        let timePickerVC = TimePickerViewController(nibName: "TimePickerViewController", bundle: nil)
        timePickerVC.modalPresentationStyle = .overCurrentContext
        timePickerVC.completion = completion
        present(timePickerVC, animated: true, completion: nil)
    }
    
    private func launchGuidedPrayer() {
        present(appDelegate.mainNavigationController,
                animated: true,
                completion: nil)
    }
    
    private func launchPeopleGroupPrayer() {
        activityIndicatorView.startAnimating()
        JoshuaProjectClient.shared.retreivePeopleGroupOfTheDay { (joshuaProjectResponse) in
            let vc = PeoplesGroups.ViewController(from: joshuaProjectResponse)
            
            DispatchQueue.main.async {
                self.present(vc, animated: true) {
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    private func launchMenu() {
        let menuVC = MenuViewController(transitioningDelegate: menuTransitioningDelegate)
        present(menuVC,
                animated: true,
                completion: nil)
    }
}
