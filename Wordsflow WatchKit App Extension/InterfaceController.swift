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

        configureDecksTable()
    }

    override func contextForSegueWithIdentifier(segueIdentifier: String,
                                                inTable table: WKInterfaceTable,
                                                rowIndex: Int) -> AnyObject? {
        return dataModel.decks[rowIndex]
    }

    private func configureDecksTable() {
        decksTable.setNumberOfRows(dataModel.decks.count, withRowType: "DeckRow")

        for (index, deck) in dataModel.decks.enumerate() {
            let row = decksTable.rowControllerAtIndex(index) as! DeckRowController
            row.name = deck.name
        }
    }

}
