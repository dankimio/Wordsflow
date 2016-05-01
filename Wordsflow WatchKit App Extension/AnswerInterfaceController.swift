//
//  AnswerInterfaceController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import WatchKit
import Foundation

protocol AnswerInterfaceControllerDelegate: class {
    func answerInterfaceController(controller: AnswerInterfaceController,
                                   didAnswerCard card: Card, withQuality quality: Int)
}

class AnswerInterfaceController: WKInterfaceController {

    @IBOutlet weak var backLabel: WKInterfaceLabel!

    var delegate: AnswerInterfaceControllerDelegate?
    var card: Card!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        guard let context = context as? [String: AnyObject] else { return }

        card = context["card"] as! Card
        delegate = context["delegate"] as? AnswerInterfaceControllerDelegate

        backLabel.setText(card.back)
    }

    @IBAction func answerAgain() { answer(1) }
    @IBAction func answerHard() { answer(2) }
    @IBAction func answerGood() { answer(3) }
    @IBAction func answerEasy() { answer(4) }

    private func answer(quality: Int) {
        delegate?.answerInterfaceController(self, didAnswerCard: card, withQuality: quality)
        dismissController()
    }

}
