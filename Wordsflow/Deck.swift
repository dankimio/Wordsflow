//
//  Deck.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation
import RealmSwift

class Deck: Object {

    dynamic var name: String = ""
    let cards = List<Card>()

    var dueCards: Results<Card> {
        let dueToday = NSPredicate(format: "dueDate < %@", NSDate())
        return cards.filter(dueToday).sorted("dueDate")
    }

    func toDictionary() -> [String: AnyObject] {
        var result = [String: AnyObject]()

        result["name"] = name
        result["cards"] = cards.map { $0.toDictionary() }

        return result
    }

}
