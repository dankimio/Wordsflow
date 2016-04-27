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

}
