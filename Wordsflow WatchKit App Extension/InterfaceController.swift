//
//  InterfaceController.swift
//  Wordsflow WatchKit App Extension
//
//  Created by Dan K. on 2016-04-30.
//  Copyright © 2016 Dan K. All rights reserved.
//

import WatchKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var decksTable: WKInterfaceTable!
    
    var dataModel = DataModel()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        configureDecksTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let deck = dataModel.decks[rowIndex]
    }

    private func configureDecksTable() {
        decksTable.setNumberOfRows(dataModel.decks.count, withRowType: "DeckRow")
        
        for (index, deck) in dataModel.decks.enumerate() {
            let row = decksTable.rowControllerAtIndex(index) as! DeckRowController
            row.name = deck.name
        }
    }

}
