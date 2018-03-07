//
//  UIView+Designable.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/26/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
