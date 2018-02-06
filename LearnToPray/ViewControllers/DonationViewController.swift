//
//  DonationViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/1/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit
import PassKit

class DonationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewElements()
    }
    
    func setUpViewElements() {
        let applePayButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .black)
        view.addSubview(applePayButton)
        applePayButton.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = NSLayoutConstraint(item: applePayButton,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .bottomMargin,
                                                        multiplier: 1.0,
                                                        constant: -8)
        let centerConstraint = NSLayoutConstraint(item: applePayButton,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0)
        view.addConstraints([bottomConstraint, centerConstraint])
    }
}
