//
//  DataModel.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation

class Deck {

    var name: String
    var cards: [Card]


    init(name: String, cards: [Card]) {
        self.name = name
        self.cards = cards
    }

}

class Card {
    
    var front: String
    var back: String
    var studiedAt: NSDate?
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
    }

}

class DataModel {
    
    var decks: [Deck]
    
    init() {
        var myDecks = [Deck]()
        for index in 1...3 {
            let cards = [
                Card(front: "Lorem", back: "Ipsum"),
                Card(front: "Dolor", back: "Sit")
            ]
            let deck = Deck(name: "Deck \(index)", cards: cards)
            myDecks.append(deck)
        }

        let emptyDeck = Deck(name: "Deck empty", cards: [])
        myDecks.append(emptyDeck)

        decks = myDecks
    }
    
}
