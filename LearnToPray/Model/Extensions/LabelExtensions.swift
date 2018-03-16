//
//  LabelExtensions.swift
//  LearnToPray
//
//  Created by Mark Tapia on 1/9/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func createLabelOnLeft() -> UILabel {
        let frame = self.frame.offsetBy(dx: -(self.frame.width),
                                        dy: 0)
        
        let label = PaddedLabel(frame: frame, sidePadding: 72)
        label.applyPrayerDetailStyling()
        return label
    }
    
    func createLabelOnRight() -> UILabel {
        let frame = self.frame.offsetBy(dx: self.frame.width,
                                        dy: 0)
       
        let label = PaddedLabel(frame: frame, sidePadding: 72)
        label.applyPrayerDetailStyling()
        return label
    }
    
    func addPadding() {
        
    }
    
    func applyPrayerDetailStyling() {
        self.numberOfLines = 0
        self.textAlignment = .center
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = true
        
    }
}
