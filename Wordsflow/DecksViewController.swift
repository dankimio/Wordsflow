//
//  DecksViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit
import RealmSwift

class DecksViewController: UITableViewController {

    let realm = try! Realm()
    let decks = try! Realm().objects(Deck)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = self.editButtonItem()
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        tableView.allowsSelectionDuringEditing = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }

        tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

//        Settings.sharedInstance.firstLaunch = true

        if Settings.sharedInstance.firstLaunch {
            performSegueWithIdentifier("ShowOnboarding", sender: self)
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

        configure(cell, withDeck: decks[indexPath.row])

        return cell
    }

    // MARK: - Table view delegate

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
            try! realm.write {
                realm.delete(decks[indexPath.row])
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {

        guard let selectedCell = tableView.cellForRowAtIndexPath(indexPath) else { return }

        if editing {
            performSegueWithIdentifier("EditDeck", sender: selectedCell)
        } else {
            performSegueWithIdentifier("ShowCards", sender: selectedCell)
        }
    }

    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView,
//                            moveRowAtIndexPath fromIndexPath: NSIndexPath,
//                            toIndexPath: NSIndexPath) {
//    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }

        let cell = sender as? UITableViewCell

        switch identifier {
        case "ShowCards": configureCardsViewController(forSegue: segue, cell: cell!)
        case "EditDeck": configureEditDeckViewController(forSegue: segue, cell: cell)
        default: return
        }
    }

    // MARK: - Helpers

    private func configure(cell: DeckCell, withDeck deck: Deck) {
        cell.nameLabel.text = deck.name

        let dueCardsCount = deck.dueCards.count
        let cardsCount = deck.cards.count

        if dueCardsCount > 0 {
            cell.descriptionLabel.text = "\(dueCardsCount) Due, \(cardsCount) Total"
            cell.indicatorView.hidden = false
        } else {
            cell.descriptionLabel.text = "Well done! No due cards. \(cardsCount) Total"
            cell.indicatorView.hidden = true
        }
    }

    private func configureCardsViewController(forSegue segue: UIStoryboardSegue,
                                                       cell: UITableViewCell) {

        let indexPath = tableView.indexPathForCell(cell)!
        let cardsViewController = segue.destinationViewController as! DeckDetailViewController

        cardsViewController.deck = decks[indexPath.row]
    }

    private func configureEditDeckViewController(forSegue segue: UIStoryboardSegue,
                                                  cell: UITableViewCell?) {

        let navigationController = segue.destinationViewController as! UINavigationController
        let editDeckViewController = navigationController.viewControllers.first
            as! EditDeckViewController
        editDeckViewController.delegate = self

        if let cell = cell, indexPath = tableView.indexPathForCell(cell) {
            editDeckViewController.deckToEdit = decks[indexPath.row]
        }
    }

}

extension DecksViewController: EditDeckViewControllerDelegate {

    func editDeckViewController(controller: EditDeckViewController,
                                didFinishAddingDeck deck: Deck) {
        tableView.reloadData()
    }

    func editDeckViewController(controller: EditDeckViewController,
                                didFinishEditingDeck deck: Deck) {

        guard let index = decks.indexOf(deck) else { return }

        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? DeckCell {
            configure(cell, withDeck: deck)
        }
    }

}
