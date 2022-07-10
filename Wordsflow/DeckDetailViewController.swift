//
//  DeckDetailViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-22.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class DeckDetailViewController: UIViewController {

    @IBOutlet weak var dueCountLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!

    var deck: Deck!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = deck.name
        dueCountLabel.text = "\(deck.dueCards.count)"
        totalCountLabel.text = "\(deck.cards.count)"
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case "ShowCards":
            let cardsViewController = segue.destinationViewController as! CardsViewController
            cardsViewController.cards = deck.cards
        case "StudyCards":
            let studyViewController = segue.destinationViewController as! StudyViewController
            studyViewController.cardsToStudy = deck.dueCards
        default: return
        }
    }

}
