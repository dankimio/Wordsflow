//
//  ExtensionDelegate.swift
//  Wordsflow WatchKit App Extension
//
//  Created by Dan K. on 2016-04-30.
//  Copyright © 2016 Dan K. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    var session = WCSession.defaultSession()

    func applicationDidFinishLaunching() {
        configureSession()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started)
        // while the application was inactive. If the application was previously in the background,
        // optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state.
        // This can occur for certain types of temporary interruptions
        // (such as an incoming phone call or SMS message) or when the user quits the application
        // and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    private func configureSession() {
        guard WCSession.isSupported() else { return }

        print("CONFIGURING SESSION ON APPLE WATCH")

        session.delegate = self
        session.activateSession()
    }

}

extension ExtensionDelegate: WCSessionDelegate {

    func session(session: WCSession,
                 didReceiveApplicationContext applicationContext: [String : AnyObject]) {

        print("Received application context \(applicationContext)")

        // Replace stored data
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier {
            userDefaults.removePersistentDomainForName(bundleIdentifier)
        }

        // Save new data
        userDefaults.setObject(applicationContext["decks"], forKey: "decks")
    }

}
