//
//  EditDeckViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-23.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

protocol EditDeckViewControllerDelegate: class {
    func editDeckViewController(controller: EditDeckViewController, didFinishAddingDeck deck: Deck)
    func editDeckViewController(controller: EditDeckViewController, didFinishEditingDeck deck: Deck)
}

class EditDeckViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var delegate: EditDeckViewControllerDelegate?
    var deckToEdit: Deck?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let deck = deckToEdit {
            nameTextField.text = deck.name
            doneBarButton.enabled = true
        }
        
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func done() {
        let name = nameTextField.text!
        
        if let deck = deckToEdit {
            deck.name = name
            delegate?.editDeckViewController(self, didFinishEditingDeck: deck)
        } else {
            delegate?.editDeckViewController(self, didFinishAddingDeck: Deck(name: name))
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension EditDeckViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range,
                                                                           withString: string)
        
        doneBarButton.enabled = newText.length > 0
        
        return true
    }
    
}