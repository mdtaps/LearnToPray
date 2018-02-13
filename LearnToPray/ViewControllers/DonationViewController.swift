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
    }
    
    @objc func purchase() {
        guard let text = donationAmountTextField.text?.currencyInputFormatting().replacingOccurrences(of: "$", with: "") else {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}

extension DonationViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        StripeNetworkingClient.shared.stripeRequest(payment: payment) { (payment) in
            let result = PKPaymentAuthorizationResult(status: payment, errors: nil)
            completion(result)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
