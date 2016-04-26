//
//  IndicatorView.swift
//  Wordsflow
//
//  Created by Dan K. on 2016-04-22.
//  Copyright © 2016 Dan K. All rights reserved.
//

import UIKit

@IBDesignable
class IndicatorView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let fillColor = UIColor(red: 20 / 255, green: 80 / 255, blue: 170 / 255, alpha: 1)
        fillColor.setFill()
        let circle = UIBezierPath(ovalInRect: rect)
        circle.fill()
    }

}
