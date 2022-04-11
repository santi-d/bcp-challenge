//
//  UILabel.swift
//  BCP-Challenge
//
//  Created by Santi D on 9/04/22.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: CGRect.zero)
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
