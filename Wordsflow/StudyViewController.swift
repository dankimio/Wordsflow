//
//  StudyViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-27.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit
import RealmSwift

class StudyViewController: UIViewController {
    
    var cardsToStudy: Results<Card>!

    override func viewDidLoad() {
        super.viewDidLoad()

        print(cardsToStudy)
    }

}
