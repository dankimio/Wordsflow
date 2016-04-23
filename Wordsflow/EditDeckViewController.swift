//
//  EditDeckViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-23.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

protocol EditDeckViewControllerProtocol: class {
    func editDeckViewController(controller: EditDeckViewController, didFinishAddingDeck deck: Deck)
    func editDeckViewController(controller: EditDeckViewController, didFinishEditingDeck deck: Deck)
}

class EditDeckViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: EditDeckViewControllerProtocol?
    var deckToEdit: Deck?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let deck = deckToEdit {
            nameTextField.text = deck.name
        }
    }
    
    @IBAction func done() {
        dismissViewControllerAnimated(true, completion: nil)
        
        let name = nameTextField.text!
        
        if let deck = deckToEdit {
            deck.name = name
            delegate?.editDeckViewController(self, didFinishEditingDeck: deck)
        } else {
            delegate?.editDeckViewController(self, didFinishAddingDeck: Deck(name: name))
        }
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
