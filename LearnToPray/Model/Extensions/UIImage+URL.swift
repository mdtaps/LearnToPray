//
//  UIImage+URL.swift
//  LearnToPray
//
//  Created by Mark Tapia on 5/24/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

extension UIImage {
    
    convenience init(fromUrl urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            
        } catch {
            self.init()
            
        }
    }
    
}
