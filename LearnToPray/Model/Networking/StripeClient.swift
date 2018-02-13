//
//  StripeClient.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/12/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import PassKit

class StripeNetworkingClient {
    
    static var shared = StripeNetworkingClient()
    
    private init() { }
    
    func stripeRequest(payment: PKPayment, amount: NSDecimalNumber, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        // 1
//        let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
        
        // 2
        Stripe.setDefaultPublishableKey("pk_test_5Frs18EDxBxYs8PpJNjqPhOd")  // Replace With Your Own Key!
        
        // 3
        STPAPIClient.shared().createToken(with: payment) {
            (token, error) -> Void in
            
            if (error != nil) {
                print(error)
                completion(PKPaymentAuthorizationStatus.failure)
                return
            }
            
            // 4
//            let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
            
            // 5
            let url = URL(string: "http://99.74.218.238:5000/pay")  // Replace with computers local IP Address!
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            // 6
            let body = ["stripeToken": token?.tokenId,
                        "amount": amount,
                        "description": "Donation to Learn to Pray"] as [String : Any]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
            } catch {
                print(error)
                completion(.failure)
            }
            
            // 7
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response, data, error) -> Void in
                if (error != nil) {
                    completion(PKPaymentAuthorizationStatus.failure)
                } else {
                    completion(PKPaymentAuthorizationStatus.success)
                }
            }
        }
        
    }
    
}


