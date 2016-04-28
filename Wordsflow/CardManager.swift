//
//  CardManager.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-29.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation
import RealmSwift

class CardManager {
    
    static let sharedInstance = CardManager()
    
    private let realm = try! Realm()
    private init() { }
    
    var dueToday: Results<Card> {
        return realm.objects(Card).filter("dueDate < %@", NSDate())
    }
    
    var dueLater: Results<Card> {
        return realm.objects(Card)
            .filter("dueDate > %@", NSDate())
            .sorted("dueDate", ascending: true)
    }
    
}
