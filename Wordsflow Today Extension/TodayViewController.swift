//
//  TodayViewController.swift
//  Wordsflow Today Extension
//
//  Created by Dan K. on 2016-05-01.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var nextSessionLabel: UILabel!
    @IBOutlet weak var decksTableView: UITableView!

    var decks = [[String: AnyObject]]()
    var nextSession: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()

        decksTableView.dataSource = self
        decksTableView.delegate = self

        preferredContentSize.height = 160

        loadData()
        configureViews()
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }

    private func loadData() {
        guard let userDefaults = NSUserDefaults(suiteName: "group.co.itsdn.Wordsflow") else {
            return
        }

        guard let savedDecks = userDefaults.dictionaryForKey("decks") else { return }

        for (name, count) in savedDecks {
            decks.append([
                "name": name,
                "count": count
            ])
        }

        nextSession = userDefaults.objectForKey("nextSession") as? NSDate
    }

    private func configureViews() {
        if let nextSession = nextSession {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = .NoStyle

            let dateString = formatter.stringFromDate(nextSession)
            nextSessionLabel.text = "Next session: \(dateString)"
        } else {
            nextSessionLabel.text = "Well done! No cards due."
        }
    }

}

extension TodayViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }

    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCell", forIndexPath: indexPath)

        if let name = decks[indexPath.row]["name"] as? String,
            count = decks[indexPath.row]["count"] as? Int {
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = "\(count)"
        }

        return cell
    }

}
