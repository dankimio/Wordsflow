//
//  Deck.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation

class Deck {

    let name: String
    
    var cards = [Card]()
    
    init(name: String) {
        self.name = name
    }

}