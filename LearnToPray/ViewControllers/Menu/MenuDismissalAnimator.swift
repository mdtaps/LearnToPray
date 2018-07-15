//
//  MenuDismissalAnimator.swift
//  LearnToPray
//
//  Created by Mark Tapia on 7/8/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation


class MenuDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration, animations: {
            fromViewController.view.transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
