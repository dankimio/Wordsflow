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
        
        return configureCardCell(forIndexPath: indexPath)
    }
    
    // MARK: - Helpers
    
    private func configureSearchBar(forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath)
    }
    
    private func configureCardCell(forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath)
        let card = cards[indexPath.row]
        cell.textLabel?.text = card.front
        return cell
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
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Navigation

    // Preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "":
            return
        default:
            return
        }
    }

}
