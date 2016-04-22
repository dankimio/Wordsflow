//
//  DecksViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class DecksViewController: UITableViewController {
    
    var decks: [Deck]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        decks = [Deck]()
        
        for i in 1...5 {
            let deck = Deck(name: "Deck \(i)")
            deck.cards.append(Card())
            decks.append(deck)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCell",
                                                               forIndexPath: indexPath) as! DeckCell

        // Configure the cell...
        let deck = decks[indexPath.row]
        cell.nameLabel.text = deck.name
        cell.descriptionLabel.text = "14 Due, 57 Total"

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView,
                            canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                            forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            decks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowCards":
                let cardsViewController = segue.destinationViewController as! DeckDetailViewController
                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
                cardsViewController.deck = decks[indexPath.row]
            default:
                return
            }
        }
    }

}
