//
//  DeckCell.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-22.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

class DeckCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
