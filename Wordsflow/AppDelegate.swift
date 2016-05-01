//
//  AppDelegate.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit
import RealmSwift
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var session = WCSession.defaultSession()

    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Customization after application launch.
        configureRealm()
        configureSession()
        cancelNotifications()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state.
        // This can occur for certain types of temporary interruptions
        // (such as an incoming phone call or SMS message) or when the user quits the application
        // and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough application state information to restore your application
        // to its current state in case it is terminated later.
        // If your application supports background execution,
        // this method is called instead of applicationWillTerminate: when the user quits.

        print("DIDENTERBACKGROUND")
        scheduleNotification()
        syncData()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state;
        // here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started)
        // while the application was inactive. If the application was previously in the background,
        // optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate.
        // Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func configureRealm() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {}
            }
        )
    }
    
    private func scheduleNotification() {
        let cardManager = CardManager.sharedInstance
        
        guard let scheduledNotifications = UIApplication
            .sharedApplication()
            .scheduledLocalNotifications where scheduledNotifications.isEmpty else {
            
            return
        }
        
        if !cardManager.dueToday.isEmpty {
            let tomorrow = NSDate().dateByAddingUnit(.Day, value: 1)
            scheduleNotification(forDate: tomorrow)
            return
        }
        
        if let card = cardManager.dueLater.first {
            scheduleNotification(forDate: card.dueDate)
            return
        }
    }
    
    private func scheduleNotification(forDate date: NSDate) {
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.alertTitle = "Time to review your cards"
        notification.alertBody = "Time to review your cards"
        notification.applicationIconBadgeNumber = 1
        notification.soundName = UILocalNotificationDefaultSoundName
        
        print("Scheduling notification: \(notification)")
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    private func cancelNotifications() {
        print("Cancelling notifications")

        let application = UIApplication.sharedApplication()
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }

    private func configureSession() {
        guard WCSession.isSupported() else { return }

        session.delegate = self
        session.activateSession()
    }

    private func syncData() {
        let realm = try! Realm()

        let context: [String: AnyObject] = [
            "decks": realm.objects(Deck).map { $0.toDictionary() }
        ]

        print("TRYING TO UPDATE CONTEXT")

        do {
            try session.updateApplicationContext(context)
            print("CONTEXT UPDATED")
        } catch {
            print("Error updating context")
        }
    }

}

extension AppDelegate: WCSessionDelegate {

    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        print("Received user info")
    }

}