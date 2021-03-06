//
//  UITextField.swift
//  BCP-Challenge
//
//  Created by Santi D on 9/04/22.
//

import UIKit

extension UITextField {
    convenience init(placeholderText: String? = nil, font: UIFont, textColor: UIColor = .bcpMetallicBlue, backgroundColor: UIColor = .clear, borderStyle: UITextField.BorderStyle = UITextField.BorderStyle.none, borderColor: UIColor = .clear, placeholderTextColor: UIColor = .bcpBlue, placeholderFont: UIFont? = nil, paddingLeft: CGFloat = 14.0, paddingRight: CGFloat = 14.0) {
        self.init(frame: .zero)
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = font
        self.textColor = textColor
        self.borderStyle = .none
        self.tintColor = textColor
        self.setBorder(borderStyle: borderStyle, borderColor: borderColor)
        self.backgroundColor = backgroundColor
        self.setPlaceholder(placeholder: placeholderText, placeholderFont: placeholderFont, placeholderColor: placeholderTextColor)

        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: 1.0))
        self.leftView = paddingLeftView
        self.leftViewMode = .always

        let paddingRightView = UIView(frame: CGRect(x: 0, y: 0, width: paddingRight, height: 1.0))
        self.rightView = paddingRightView
        self.rightViewMode = .always
    }

    func setPlaceholder(placeholder: String?, placeholderFont: UIFont?, placeholderColor: UIColor) {
        guard let placeholder = placeholder, let font = self.font else { return }
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: placeholderColor,
                NSAttributedString.Key.font: placeholderFont ?? font
            ]
        )
    }

    func setBorder(borderStyle: UITextField.BorderStyle, borderColor: UIColor) {
        switch borderStyle {
        case .line:
            self.layer.borderWidth = 1.0
            self.layer.borderColor = borderColor.cgColor
        case .none:
            self.layer.borderWidth = 0.0
            self.layer.borderColor = nil
        default: break
        }
    }
}
