//
//  OnboardingViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-28.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController {

    var identifiers = ["First", "Second", "Third", "Fourth"]
    var controllers: [UIViewController]!

    override func viewDidLoad() {
        super.viewDidLoad()

        controllers = identifiers.map { storyboard!.instantiateViewControllerWithIdentifier($0) }
        setViewControllers([controllers[0]], direction: .Forward, animated: true, completion: nil)

        let pageControlAppearance = UIPageControl.appearanceWhenContainedInInstancesOfClasses(
            [OnboardingViewController.self])
        pageControlAppearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControlAppearance.currentPageIndicatorTintColor = UIColor.darkGrayColor()

        delegate = self
        dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(
        pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = controllers.indexOf(viewController) else { return nil }

        let previousIndex = currentIndex - 1
        return validIndex(previousIndex) ? controllers[previousIndex] : nil
    }

    func pageViewController(
        pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = controllers.indexOf(viewController) else { return nil }

        let nextIndex = currentIndex + 1
        return validIndex(nextIndex) ? controllers[nextIndex] : nil
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return identifiers.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    private func validIndex(index: Int) -> Bool {
        return index >= 0 && index < identifiers.count
    }

}
