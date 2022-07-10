//
//  Scheduler.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import Foundation
import RealmSwift

struct Scheduler {

    let maxQuality = 5
    let qualitySubtractor = 5.0
    let minEasinessFactor = 1.3
    let minInterval = 1

    let card: Card
    let quality: Int

    let realm = try! Realm()

    init(card: Card, quality: Int) {
        self.card = card
        self.quality = quality
    }

    func schedule() {
        try! realm.write {
            card.easinessFactor = newEasinessFactor
            calculateInterval()
            card.dueDate = card.dueDate.dateByAddingUnit(.Day, value: 1)
            card.studiedAt = NSDate()
        }
    }

    private func calculateInterval() {
        if card.easinessFactor < 3.0 {
            card.repetitions = 0
        }

        if card.repetitions == 2 {
            card.interval = 6
        } else if card.repetitions > 2 {
            card.interval = Int(round(Double(card.interval) * card.easinessFactor))
        }
    }

    private var newEasinessFactor: Double {
        let qualityFactor = qualitySubtractor - Double(quality)
        let result = card.easinessFactor + (0.1 - qualityFactor * (0.08 + qualityFactor * 0.02))
        return (result < minEasinessFactor ? minEasinessFactor : result)
    }

}

extension NSDate {

    func dateByAddingUnit(unit: NSCalendarUnit, value: Int) -> NSDate {
        return NSCalendar
            .currentCalendar()
            .dateByAddingUnit(unit,
                              value: value,
                              toDate: self,
                              options: NSCalendarOptions(rawValue: 0))!
    }

}
