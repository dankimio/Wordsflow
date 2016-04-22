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

    @IBInspectable var defaultColor = UIColor.blueColor()
    @IBInspectable var highlightedColor = UIColor.redColor()
    
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
