//
//  CardsViewController.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-21.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class CardsViewController: UITableViewController {
    
    var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false
        controller.dimsBackgroundDuringPresentation = false
        controller.definesPresentationContext = true
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    var cards: [Card]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.loadViewIfNeeded()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchController.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CardCell",
                                                               forIndexPath: indexPath)
        configure(cell, forCard: cards[indexPath.row])
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier("EditCard", sender: cell)
    }
    
    // Support conditional editing of the table view.
    override func tableView(tableView: UITableView,
                            canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Support editing the table view.
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            cards.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Helpers
    
    private func configure(cell: UITableViewCell, forCard card: Card) {
        cell.textLabel!.text = card.front
        cell.detailTextLabel!.text = card.back
    }

    // MARK: - Navigation

    // Preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier where identifier == "EditCard" else { return }
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let editCardViewController = navigationController.viewControllers.first!
            as! EditCardViewController
        editCardViewController.delegate = self
        
        if let cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(cell) {
            editCardViewController.cardToEdit = cards[indexPath.row]
        }
    }

}

extension CardsViewController: EditCardViewControllerDelegate {
    
    func editCardViewController(controller: EditCardViewController,
                                didFinishAddingCard card: Card) {
        cards.append(card)
        tableView.reloadData()
    }
    
    func editCardViewController(controller: EditCardViewController,
                                didFinishEditingCard card: Card) {
        
        guard let index = cards.indexOf({ $0 === card }) else { return }
        
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            configure(cell, forCard: card)
        }
    }
}
