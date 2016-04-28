//
//  OnboardingPageViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-28.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIViewController {
    
    @IBAction func populate() {
        Populator().populate()
    }
    
    @IBAction func registerNotifications() {
        print("registerNotifications")
    }
    
}
