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
        
        let label = UILabel(frame: frame)
        return label
    }
    
    func createLabelOnRight() -> UILabel {
        print(self.frame.origin)

        let frame = self.frame.offsetBy(dx: self.frame.width,
                                        dy: 0)
       
        let label = UILabel(frame: frame)
        print(label.frame.origin)

        return label
    }
}
