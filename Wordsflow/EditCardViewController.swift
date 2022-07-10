//
//  EditCardViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-23.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit
import RealmSwift

protocol EditCardViewControllerDelegate {
    func editCardViewController(controller: EditCardViewController, didFinishAddingCard card: Card)
    func editCardViewController(controller: EditCardViewController, didFinishEditingCard card: Card)
}

class EditCardViewController: UITableViewController {

    @IBOutlet weak var frontTextView: UITextView!
    @IBOutlet weak var backTextView: UITextView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    let realm = try! Realm()

    var delegate: EditCardViewControllerDelegate?
    var cardToEdit: Card?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let card = cardToEdit {
            frontTextView.text = card.front
            backTextView.text = card.back
            doneBarButton.enabled = true
        }

        frontTextView.becomeFirstResponder()
    }

    @IBAction func done() {
        let front = frontTextView.text
        let back = backTextView.text

        if let card = cardToEdit {
            try! realm.write {
                card.front = front
                card.back = back
            }
            delegate?.editCardViewController(self, didFinishEditingCard: card)
        } else {
            let card = Card()
            card.front = front
            card.back = back
            try! realm.write { realm.add(card) }
            delegate?.editCardViewController(self, didFinishAddingCard: card)
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension EditCardViewController: UITextViewDelegate {

    func textViewDidChange(textView: UITextView) {
        doneBarButton.enabled = frontTextView.text.characters.count > 0 &&
            backTextView.text.characters.count > 0
    }

}
