//
//  DeckRowController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import WatchKit

class DeckRowController: NSObject {
    
    @IBOutlet weak var deckNameLabel: WKInterfaceLabel!
    
    var deckName: String! {
        didSet {
            if let name = deckName {
                deckNameLabel.setText(name)
            }
        }
    }

}
