//
//  UIButtonExtensions.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/15/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

extension UIButton {
    
    func applyNoPaymentStyling() {
        self.frame.size = CGSize(width: 300, height: 48)
        self.setTitle("Unable to Accept Payments", for: .normal)
    }
}
