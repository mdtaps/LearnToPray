//
//  DonationViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/1/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit
import PassKit

class DonationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var donationAmountTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewElements()
        donationAmountTextField.delegate = self
    }
    
    @IBAction func tapOutsideTextField() {
        donationAmountTextField.resignFirstResponder()
    }
    
    @IBAction func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func purchase() {
        guard let text = donationAmountTextField.text else {
            return
        }
        
        let donationAmount = NSDecimalNumber(string: text)
        ApplePaySetUp.donationAmount = donationAmount
        if let applePayController = ApplePaySetUp.makeApplePayController() {
            donationAmountTextField.resignFirstResponder()
            applePayController.delegate = self
            present(applePayController, animated: true, completion: nil)
        }
    }
    
    private func setUpViewElements() {
        var paymentButton = UIButton(type: .roundedRect)
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: ApplePaySetUp.SupportedPaymentNetworks) {
            paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        } else {
            paymentButton.applyNoPaymentStyling()
            
        }
        view.addSubview(paymentButton)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Set button constraints to bottom middle of the screen
        let bottomConstraint = KeyboardLayoutConstraint(item: paymentButton,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: backgroundView,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: -60)
        let centerConstraint = NSLayoutConstraint(item: paymentButton,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: backgroundView,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0)
        view.addConstraints([bottomConstraint, centerConstraint])
        
        //Set up button tap
        let applePayButtonTap = UITapGestureRecognizer(target: self, action: #selector(purchase))
        paymentButton.addGestureRecognizer(applePayButtonTap)
        paymentButton.isUserInteractionEnabled = true
    }
}

extension DonationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            return true
            
        }
        
        let regex = try! NSRegularExpression(pattern: "[0-9]", options: .caseInsensitive)
        let match = regex.matches(in: string, options: .init(rawValue: 0), range: NSMakeRange(0, string.count))
        
        if match.isEmpty {
            return false
            
        }
        return true
        
    }
    
}

extension DonationViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        StripeNetworkingClient.shared.stripeRequest(payment: payment, amount: ApplePaySetUp.donationAmount) { (paymentStatus) in
            let result = PKPaymentAuthorizationResult(status: paymentStatus, errors: nil)
            completion(result)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
