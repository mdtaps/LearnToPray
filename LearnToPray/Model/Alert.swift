//
//  Alert.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/12/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct Alert {
    static func NetworkFailure() -> UIAlertController {
        let alert = UIAlertController(title: "Network Error", message: "Could not retreive People Group data", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)

        return alert
    }
}
