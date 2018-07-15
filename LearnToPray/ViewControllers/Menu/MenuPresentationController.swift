//
//  MenuPresentationController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 7/3/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import UIKit

final class MenuPresentationController: UIPresentationController {
    
    fileprivate var dimmingView: UIView!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let height = (containerView?.bounds.height)!
        let width = (containerView?.bounds.width)! * 0.7
        return CGRect(x: (containerView?.bounds.width)! - width, y: 0, width: width, height: height)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimmingView, at: 0)
        dimmingView.frame = (containerView?.bounds)!
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 0.0
        }) { (context) in
            self.dimmingView.removeFromSuperview()
        }
    }
}

private extension MenuPresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
