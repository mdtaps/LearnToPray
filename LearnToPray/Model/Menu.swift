//
//  Setting.swift
//  LearnToPray
//
//  Created by Mark Tapia on 6/22/18.
//  Copyright © 2018 Mark Tapia. All rights reserved.
//

import Foundation
import MessageUI
import StoreKit

struct MenuOption {
    let title: String
    let launcher: () -> ()
}

class Menu {
    var options = [MenuOption]()
    let viewController: UIViewController
    
    init(with viewController: UIViewController) {
        self.viewController = viewController
        options = createMenuOptions()
    }
}

extension Menu {
    private func createMenuOptions() -> [MenuOption] {
        var options = [MenuOption]()
        
        let contactOption = MenuOption(title: "Contact Developer",
                                       launcher: launchContact)
        options.append(contactOption)
        
        let donateOption = MenuOption(title: "Donate",
                                      launcher: launchDonate)
        options.append(donateOption)
        
        let aboutOption = MenuOption(title: "About",
                                      launcher: launchAbout)
        options.append(aboutOption)
        
        let reviewOption = MenuOption(title: "Review App", launcher: launchReviewRequest)
        options.append(reviewOption)
        
        return options
    }
    
    private func launchContact() {
        guard viewController is MFMailComposeViewControllerDelegate else {
            return
        }
        
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = (viewController as! MFMailComposeViewControllerDelegate)
        mailController.setToRecipients(MailComponentConstants.ToRecipients)
        
        viewController.present(mailController, animated: true, completion: nil)
    }
    
    private func launchDonate() {
        let url = URL(string: "https://www.paypal.me/mdtaps")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func launchAbout() {
        let navController = SoloNavigationViewController()
        navController.viewControllers = [AboutViewController()]
        self.viewController.present(navController,
                                    animated: true,
                                    completion: nil)
    }
    
    private func launchReviewRequest() {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            let url = URL(string: URLConstants.LearnToPrayAppStoreUrl)!
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        }
    }
}
