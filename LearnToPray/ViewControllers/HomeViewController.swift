//
//  HomeViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/16/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func guidedPrayerTapped() {
       launchGuidedPrayer()
    }
    
    @IBAction func startPrayingTapped() {
        launchPrayerTime()
    }
    
    @IBAction func aboutTapped() {
        launchAboutVC()
    }
    
    @IBAction func peopleGroupTapped() {
        launchPeopleGroupPrayer()
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
    
    private func launchAboutVC() {
        let navController = UINavigationController()
        let aboutVC = AboutViewController(nibName: nil, bundle: nil)
        aboutVC.title = "About Learn to Pray"
        navController.viewControllers = [aboutVC]
        navController.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                                 style: .done,
                                                                                 target: aboutVC,
                                                                                 action: #selector(aboutVC.dismissVC))
        present(navController, animated: true, completion: nil)
    
    }
    
    private func launchGuidedPrayer() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        
        present(navigationController, animated: true, completion: nil)
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
}
