//
//  DataModel.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation

class Card {
    
    var front: String
    var back: String
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
    }
    
}

class DataModel {
    
    var decks: [String: [Card]]
    
    init() {
        decks = [
            "Lorem": [Card(front: "Hello", back: "World"), Card(front: "A", back: "B")],
            "Ipsum": [Card(front: "Lalka", back: "Lolol"), Card(front: "Hey", back: "Kek")]
        ]
    }
    
}