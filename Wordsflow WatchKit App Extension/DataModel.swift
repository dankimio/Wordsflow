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
    
    var decks = [Deck]()
    
    init() {
        let userDefaults = NSUserDefaults.standardUserDefaults()

        guard let context = userDefaults.arrayForKey("decks") else {
            decks = [Deck]()
            return
        }

        for deck in context {
            let savedCards = deck["cards"] as! NSArray
            var cards = [Card]()
            for card in savedCards {
                if let card = card as? [String: AnyObject] {
                    cards.append(Card(front: card["front"] as! String, back: card["back"] as! String))
                }
            }

            let savedDeck = Deck(name: deck["name"] as! String, cards: cards)
            decks.append(savedDeck)
        }
    }
    
}
