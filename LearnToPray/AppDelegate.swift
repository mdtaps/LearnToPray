//
//  AppDelegate.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/9/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var stack = CoreDataStack(modelName: "CoreDataModel")!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        JoshuaProjectClient.shared.jpGETRequest { (result) in
            switch result {
            case .Success(let responseData):
                print("Yay! Success!")
            case .Failure(let failureString):
                print("Failure: \(failureString)")
            }
        }
        
        if !UserDefaultsManager.hasLaunchedPreviously {
            setData()
            parseJSON { (prayerList, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                    
                }
                
                guard let prayerList = prayerList else {
                    return
                    
                }
                
                for category in prayerList.category {
                    if let categoryEntity = NSEntityDescription.insertNewObject(forEntityName: "Category", into: self.stack.context) as? Category {
                        categoryEntity.name = category.name
                        for prayer in category.prayer {
                            if let prayerEntity = NSEntityDescription.insertNewObject(forEntityName: "Prayer", into: self.stack.context) as? Prayer {
                                categoryEntity.addToPrayer(prayerEntity)
                                prayerEntity.name = prayer.name
                                prayerEntity.category = categoryEntity
                                
                                if let text = prayer.text {
                                    prayerEntity.text = text
                                    
                                }
                                
                                if let prayerDetails = prayer.details {
                                    for details in prayerDetails {
                                        if let detailsEntity = NSEntityDescription.insertNewObject(forEntityName: "Details", into: self.stack.context) as? Details {
                                            prayerEntity.addToDetails(detailsEntity)
                                            detailsEntity.prayer = prayerEntity
                                            
                                            if let title = details.title {
                                                detailsEntity.title = title
                                                
                                            }
                                            
                                            if let text = details.text {
                                                detailsEntity.text = text
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            stack.save()
            UserDefaultsManager.hasLaunchedPreviously = true
        }
        
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        stack.save()

    }


}

