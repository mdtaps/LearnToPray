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
    
    let applePaySetUp = ApplePaySetUp()
    @IBOutlet weak var donationAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewElements()
        //Add KeyboardDidShow listeners
    }
    
    //TODO: Add Keyboard Showing Shift
    
    @objc func purchase() {
        if let applePayController = ApplePaySetUp.makeApplePayController() {
            present(applePayController, animated: true, completion: nil)
        }
    }
    
    private func setUpViewElements() {
        var paymentButton = UIButton()
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: ApplePaySetUp.SupportedPaymentNetworks) {
            paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        } else {
            paymentButton = UIButton(type: .roundedRect)
            paymentButton.frame.size = CGSize(width: 300, height: 48)
            paymentButton.setTitle("Unable to Accept Payments", for: .normal)
        }
        view.addSubview(paymentButton)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Set button constraints to bottom middle of the screen
        let bottomConstraint = NSLayoutConstraint(item: paymentButton,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .bottomMargin,
                                                        multiplier: 1.0,
                                                        constant: -16)
        let centerConstraint = NSLayoutConstraint(item: paymentButton,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0)
        view.addConstraints([bottomConstraint, centerConstraint])
        
        //Set up button tap
        let applePayButtonTap = UIGestureRecognizer(target: self, action: #selector(purchase))
        paymentButton.addGestureRecognizer(applePayButtonTap)
        
        print("Height is: \(paymentButton.frame.height)")
    }
}

extension DonationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}
