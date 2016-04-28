//
//  OnboardingContainerViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-28.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    @IBAction func skip() {
        dismissOnboarding()
    }
    
    @IBAction func finish(segue: UIStoryboardSegue) {
        dismissOnboarding()
    }
    
    private func dismissOnboarding() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
