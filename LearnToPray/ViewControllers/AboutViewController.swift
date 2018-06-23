//
//  AboutViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 4/8/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        self.title = "About Learn to Pray"
    }
    
    @IBAction func contactButtonPressed(_ sender: UIButton) {
        let url = URL(string: "mailto:contactlearntopray@gmail.com")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func donateButtonPressed(_ sender: UIButton) {
        let url = URL(string: "https://www.paypal.me/mdtaps")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
