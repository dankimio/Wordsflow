//
//  Settings.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-28.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation

class Settings {

    static let sharedInstance = Settings()

    private init() {
        registerDefaults()
    }

    private let userDefaults = NSUserDefaults.standardUserDefaults()
    private let notificationCenter = NSNotificationCenter.defaultCenter()

    private struct Options {
        static let firstLaunch = "Settings.firstLaunch"
    }

    var firstLaunch: Bool {
        get { return userDefaults.boolForKey(Options.firstLaunch) }
        set { userDefaults.setBool(newValue, forKey: Options.firstLaunch) }
    }

    private func registerDefaults() {
        let defaults = [Options.firstLaunch: true]
        userDefaults.registerDefaults(defaults)
    }

}
