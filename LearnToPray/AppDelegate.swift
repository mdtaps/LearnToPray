//
//  AppDelegate.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/9/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    
    var stack = CoreDataStack(modelName: "CoreDataModel")!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        launchRootVC()
        
        if !UserDefaultsManager.hasLaunchedPreviously {
            setupPrayerData()
        }
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        center.requestAuthorization(options: options) { (success, error) in }
        
        return true
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if PrayerTimer.timerState == .Running {
            
            let request = createNotificationRequest()
            center.add(request) { (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        center.removeAllPendingNotificationRequests()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        stack.save()

    }
    
    private func launchRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
    
    private func setupPrayerData() {
        PrayerData.setData()
        PrayerData.parseJSON { (prayerList, error) in
            if let error = error {
                print(error.localizedDescription)
                return
                
            }
            
            guard let prayerList = prayerList else {
                print("No Prayer List")
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
                                        
                                        detailsEntity.dateAdded = NSDate(timeIntervalSinceNow: 0)
                                        
                                        
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
    
    private func createNotificationRequest() -> UNNotificationRequest {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: PrayerTimer.timeLeftPraying, repeats: false)
        
        let identifier = "PrayerTimerNotification"
        
        let content = UNMutableNotificationContent()
        content.title = "Prayer Complete"
        content.body = "Your prayer timer has finished!"
        content.sound = UNNotificationSound(named: "chimes.wav")
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        return request
    }
    
}

