//
//  Setting.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/22/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct MenuOption {
    
    let title: String
    let viewController: UIViewController
}

struct MenuOptions {
    
    var menuOptions = [MenuOption]()
    
    init() {
        menuOptions = createMenuOptions()
    }
}

extension MenuOptions {
    func createMenuOptions() -> [MenuOption] {
        var options = [MenuOption]()
        
        let navController = SoloNavigationViewController()
        navController.viewControllers = [AboutViewController()]
        let aboutOption = MenuOption(title: "About", viewController: navController)
        options.append(aboutOption)
        return options
    }
}
