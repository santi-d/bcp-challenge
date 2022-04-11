//
//  UIView.swift
//  BCP-Challenge
//
//  Created by Santi D on 9/04/22.
//

import UIKit

public enum BoundsType {
    case vertical
    case horizontal
    case full
}

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }

    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }

    func getTopAnchor() -> NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.topAnchor
    }

    func getBottomAnchor() -> NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.bottomAnchor
    }

    func getRightAnchor() -> NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.rightAnchor
    }

    func getLeftAnchor() -> NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.leftAnchor
    }

    func getBottomHeight() -> CGFloat {
        self.safeAreaInsets.bottom
    }

    func bind(withConstant constant: CGFloat, boundType: BoundsType) {
        self.bindFrameToSafeLayoutArea(withConstant: constant, boundType: boundType)
    }

    func bindFrameToSafeLayoutArea(withConstant constant: CGFloat, boundType: BoundsType) {
        guard let superView = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        switch boundType {
        case .vertical:
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -1.0 * constant).isActive = true
        case .horizontal:
            self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant: -1.0 * constant).isActive = true
            self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: constant).isActive = true
        case .full:
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -1.0 * constant).isActive = true
            self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant: -1.0 * constant).isActive = true
            self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: constant).isActive = true
        }
    }
}
