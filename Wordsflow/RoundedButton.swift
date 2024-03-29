//
//  RoundedButton.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-22.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var defaultColor: UIColor = UIColor.blueColor() {
        didSet {
            layer.backgroundColor = defaultColor.CGColor
        }
    }

    @IBInspectable var highlightedColor: UIColor = UIColor(red: 10 / 255, green: 70 / 255, blue: 160 / 255, alpha: 1) {
        didSet {
            if highlighted { layer.backgroundColor = highlightedColor.CGColor }
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet { layer.cornerRadius = cornerRadius }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        layer.backgroundColor = defaultColor.CGColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.backgroundColor = defaultColor.CGColor
    }

    override var highlighted: Bool {
        didSet {
            layer.backgroundColor = highlighted ? highlightedColor.CGColor : defaultColor.CGColor
        }
    }

}
