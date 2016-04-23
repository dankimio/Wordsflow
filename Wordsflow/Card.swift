//
//  Card.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation

class Card {
    
    var front: String
    var back: String

    var easinessFactor: Double
    var interval: Int
    var repetitions: Int

    init() {
        front = "Front"
        back = "Back"

        easinessFactor = 2.5
        repetitions = 0
        interval = 0
    }

}
