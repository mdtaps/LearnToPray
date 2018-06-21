//
//  PeoplesGroups.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/21/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

struct PeoplesGroups {
    static func ViewController(from response: Result<JoshuaProjectObject>) -> UIViewController {
        var vc = UIViewController()
        switch response {
        case .Failure(let failureString):
            print(failureString)
            vc = Alert.NetworkFailure()
        case .Success(let data):
            vc = PeoplesGroups.CreateViewController(data: data)
        }
        
        return vc
    }
    
    private static func CreateViewController(data response: JoshuaProjectObject) -> UIViewController {
        let navController = UINavigationController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let peopleGroupVC = storyboard.instantiateViewController(withIdentifier: "PeopleGroupsViewController") as? PeopleGroupsViewController else {
            fatalError("Check stroyboard for missing PeopleGroupsViewController")
        }
        
        peopleGroupVC.joshuaProjectObject = response
        peopleGroupVC.title = "People Groups"
        navController.viewControllers = [peopleGroupVC]
        navController.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                                 style: .done,
                                                                                 target: peopleGroupVC,
                                                                                 action: #selector(peopleGroupVC.dismissVC))
        return navController
    }
}
