//
//  DeckRowController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import WatchKit

class DeckRowController: NSObject {
    
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    
    var name: String! {
        didSet {
            guard let name = name else { return }
            nameLabel.setText(name)
        }
    }

}
