//
//  UIStackView+Styling.swift
//  LearnToPray
//
//  Created by Mark Tapia on 3/12/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

extension UIStackView {
    
    func applyVerticalStyling() {
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .fill
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
