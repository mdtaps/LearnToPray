//
//  UIButton+Enablement.swift
//  LearnToPray
//
//  Created by Mark Tapia on 3/19/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

class NextButton: UIButton {
    var disableValue: Int = 0
    
    func setStatusFor(currentValueOf rowValue: Int) {
        if disableValue == rowValue {
            self.isEnabled = false
        } else {
            self.isEnabled = true
        }
    }
}
