//
//  UIView+Constraints.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 23/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func prepareForConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func pinEdgesToSuperview(_ offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset).isActive = true
        self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: offset).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset).isActive = true
    }

    @discardableResult
    func centerVertically(inRelationTo: UIView, _ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        let superview = inRelationTo

        let constraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinLeft(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        let constraint = self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinLeftInRelationTo(heightAnchor:NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint? {
        let constraint = self.leftAnchor.constraint(equalTo: heightAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinRight(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        let constraint = self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinRightInRelationTo(heightAnchor:NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint? {
        let constraint = self.rightAnchor.constraint(equalTo: heightAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinTop(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        var constraint: NSLayoutConstraint?

        if let target = target {
            constraint = self.topAnchor.constraint(equalTo: target.bottomAnchor, constant: offset)
        } else {
            constraint = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset)
        }

        constraint?.isActive = true
        return constraint
    }

    @discardableResult
    func pinBottom(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }

        guard let target = target else {
            let constraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset)
            constraint.isActive = true
            return constraint
        }

        let constraint = self.bottomAnchor.constraint(equalTo: target.topAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func constraintWidth(toAnchor: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint? {
        let constraint = self.widthAnchor.constraint(equalTo: toAnchor, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func squareViewConstraint() -> NSLayoutConstraint? {
        let constraint = self.widthAnchor.constraint(equalTo: self.heightAnchor)
        constraint.isActive = true
        return constraint
    }
}
