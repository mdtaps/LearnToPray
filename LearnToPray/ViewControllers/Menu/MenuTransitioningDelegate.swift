//
//  MenuTransitioningDelegate.swift
//  LearnToPray
//
//  Created by Mark Tapia on 7/3/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation

class MenuTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuDismissalAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuPresentationAnimator()
    }
}
