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
    
    var menuOptions: [MenuOption]
    
    init() {
        menuOptions = createMenuOptions()
    }
}

extension MenuOptions {
    func createMenuOptions() -> [MenuOption] {
        var options = [MenuOptions]()
        
        let navController = UINavigationController()
        let aboutVC = AboutViewController(nibName: nil, bundle: nil)
        navController.viewControllers = [aboutVC]
        navController.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                                 style: .done,
                                                                                 target: aboutVC,
                                                                                 action: #selector(aboutVC.dismissVC))
        present(navController, animated: true, completion: nil)
        
        let aboutOption = MenuOption(title: "About", viewController: navController)
    }
}
