//
//  UITableViewCell.swift
//  BCP-Challenge
//
//  Created by Santi D on 9/04/22.
//

import UIKit

extension UITableViewCell {
    func setupBackground(backgroundColor: UIColor = .white) {
        self.selectionStyle = .none
        self.contentView.backgroundColor = backgroundColor
        self.backgroundColor = backgroundColor
    }
}
