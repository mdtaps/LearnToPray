//
//  MarginLabel.swift
//  LearnToPray
//
//  Created by Mark Tapia on 2/28/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    
    var leftPadding: CGFloat = 0.0
    var rightPadding: CGFloat = 0.0
    
    convenience init(frame: CGRect,
                     sidePadding: CGFloat) {
        self.init(frame: frame)
        self.leftPadding = sidePadding
        self.rightPadding = sidePadding
        
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
