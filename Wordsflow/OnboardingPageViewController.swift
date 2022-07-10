//
//  OnboardingPageViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-28.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIViewController {

//    @IBAction func populate() {
//        Populator().populate()
//    }
    @IBAction func populate(sender: RoundedButton) {
        Populator().populate()
        sender.setTitle("Success", forState: .Normal)
        sender.enabled = false
    }

    @IBAction func registerNotifications() {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound],
                                                              categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }

}
