//
//  Populator.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-28.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation
import RealmSwift

class Populator {
    
    let files = [
        "World Capitals": "world_capitals",
        "U.S. Capitals": "us_capitals"
    ]
    
    let realm = try! Realm()
    
    func populate() {
        // Open data file
        for (name, path) in files {
            guard let
                file = NSBundle.mainBundle().pathForResource(path, ofType: "json"),
                rawData = NSData(contentsOfFile: file) else { return }

            if let data = try!
                NSJSONSerialization.JSONObjectWithData(rawData, options: [])
                as? [[String: String]] {

                populateDeck(withName: name, andData: data)
            }
        }
    }
    
    private func populateDeck(withName name: String, andData data: [[String: String]]) {
        if realm.objects(Deck).filter("name == %@", name).count > 0 { return }
        
        let deck = Deck()
        deck.name = name
        try! realm.write { realm.add(deck) }
        
        let cards = data.map { value in Card(value: value) }
        try! realm.write { deck.cards.appendContentsOf(cards) }
    }
    
}
