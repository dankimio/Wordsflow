//
//  EditCardViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-23.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

protocol EditCardViewControllerDelegate {
    func editCardViewController(controller: EditCardViewController, didFinishAddingCard card: Card)
    func editCardViewController(controller: EditCardViewController, didFinishEditingCard card: Card)
}

class EditCardViewController: UITableViewController {
    
    @IBOutlet weak var frontTextView: UITextView!
    @IBOutlet weak var backTextView: UITextView!
    
    var delegate: EditCardViewControllerDelegate?
    var cardToEdit: Card?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let card = cardToEdit {
            frontTextView.text = card.front
            backTextView.text = card.back
        }
    }

    @IBAction func done() {
        let front = frontTextView.text
        let back = backTextView.text
        
        if let card = cardToEdit {
            card.front = front
            card.back = back
            delegate?.editCardViewController(self, didFinishEditingCard: card)
        } else {
            let card = Card()
            card.front = front
            card.back = back
            delegate?.editCardViewController(self, didFinishAddingCard: card)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }

}
