//
//  StripeClient.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/12/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//
//  Copied from raywenderlich.com tutorial

import Foundation
import PassKit

class StripeNetworkingClient {
    
    static var shared = StripeNetworkingClient()
    
    private init() { }
    
    func stripeRequest(payment: PKPayment, amount: NSDecimalNumber, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        Stripe.setDefaultPublishableKey("Insert Your Key Here")
        
        STPAPIClient.shared().createToken(with: payment) {
            (token, error) -> Void in
            
            if (error != nil) {
                print(error as Any)
                completion(.failure)
                return
                
            }
            
            guard let token = token else {
                print("No token in STPAPIClient createToken")
                completion(.failure)
                return
                
            }
            
            let url = URL(string: "Enter Server IP and path here")  // Replace with computers local IP Address!
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let body = ["stripeToken": token.tokenId,
                        "amount": amount,
                        "description": "Donation to Learn to Pray"] as [String : Any]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
                
            } catch {
                print(error)
                completion(.failure)
                
            }
            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if (error != nil) {
                    print("URL Session Data Task Failed")
                    completion(.failure)
                    
                } else {
                    print("URL Session Data Task Succeeded")
                    completion(.success)
                    
                }
                
            }.resume()
            
        }
        
    }
    
}


