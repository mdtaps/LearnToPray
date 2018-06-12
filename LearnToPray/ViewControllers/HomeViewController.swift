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
        activityIndicatorView.isHidden = false
        JoshuaProjectClient.shared.retreivePeopleGroupOfTheDay { (joshuaProjectResponse) in
            switch joshuaProjectResponse {
            case .Failure(let failureString):
                print(failureString)
                DispatchQueue.main.async {
                    self.present(Alert.NetworkFailure(), animated: true) {
                        self.activityIndicatorView.isHidden = true
                        self.activityIndicatorView.stopAnimating()
                    }
                }
                
            case .Success(let response):
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.launchPeopleGroupViewController(response)
                    
                }
            }
        }
    }
    
    private func launchPeopleGroupViewController(_ response: JoshuaProjectObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PeopleGroupsViewController") as? PeopleGroupsViewController else {
                       fatalError("Check stroyboard for missing PeopleGroupsViewController")
        }
        
        vc.joshuaProjectObject = response
        present(vc, animated: true, completion: nil)
    }
}
