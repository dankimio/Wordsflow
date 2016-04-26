//
//  Card.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    
    dynamic var front: String = ""
    dynamic var back: String = ""

    dynamic var easinessFactor: Double = 2.5
    dynamic var interval: Int = 0
    dynamic var repetitions: Int = 0

//    init() {
//        front = "Front"
//        back = "Back"
//
//        easinessFactor = 2.5
//        repetitions = 0
//        interval = 0
//    }

}
