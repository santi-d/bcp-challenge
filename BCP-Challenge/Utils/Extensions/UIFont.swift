//
//  UIFont.swift
//  BCP-Challenge
//
//  Created by Santi D on 9/04/22.
//

import UIKit

extension UIFont {
    class func bcpBook(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: Weight.regular)
    }

    class func bcpMedium(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: Weight.medium)
    }

    class func bcpBold(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: Weight.bold)
    }
}
