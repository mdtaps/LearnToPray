//
//  SoloNavigationViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/23/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

class SoloNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                        style: .done,
                                                                        target: self,
                                                                        action: #selector(self.dismissVC))
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
