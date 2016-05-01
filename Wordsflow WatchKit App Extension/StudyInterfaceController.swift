//
//  StudyInterfaceController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import WatchKit
import Foundation


class StudyInterfaceController: WKInterfaceController {

    @IBOutlet weak var frontLabel: WKInterfaceLabel!

    var deck: Deck!
    var currentCard: Card?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        deck = context as! Deck

        configureCurrentCard()
    }

    override func willActivate() {
        super.willActivate()

        if let card = currentCard {
            frontLabel.setText(card.front)
        } else {
            popController()
        }
    }

    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        guard segueIdentifier == "ShowAnswer" else { return nil }

        let context: [String: AnyObject] = ["delegate": self, "card": currentCard!]
        return context
    }

    private func configureCurrentCard() {
        if let card = deck.cards.first {
            currentCard = card
        } else {
            currentCard = nil
        }
    }

}

extension StudyInterfaceController: AnswerInterfaceControllerDelegate {

    func answerInterfaceController(controller: AnswerInterfaceController,
                                   didAnswerCard card: Card,
                                   withQuality quality: Int) {

        card.studiedAt = NSDate()

        // Send data back to watch using connectivity

        // Remove card from data model
        if let index = deck.cards.indexOf({ $0 === card }) {
            deck.cards.removeAtIndex(index)
        }

        configureCurrentCard()
    }

}
