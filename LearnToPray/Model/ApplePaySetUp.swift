//
//  ApplePaySetUp.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/6/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import PassKit

struct ApplePaySetUp {
    
    static let SupportedPaymentNetworks: [PKPaymentNetwork] = [.visa, .discover, .amex, .masterCard]
    static let ApplePayMerchantID = "merchant.com.marktapia"
    static var donationAmount: NSDecimalNumber = 0.0
    
    static func makeApplePayController() -> PKPaymentAuthorizationViewController? {
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePayMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Donation Amount", amount: donationAmount),
            PKPaymentSummaryItem(label: "Learn To Pray", amount: donationAmount)
        ]
        
        return PKPaymentAuthorizationViewController(paymentRequest: request)
    }
}
