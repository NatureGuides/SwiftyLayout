//
//  ConstraintType.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 18/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A type to apply to a Unary or Binary constraint.
@objc public enum ConstraintType: Int
{
    case equalTo, lessThanOrEqualTo, greaterThanOrEqualTo
}

internal extension NSLayoutAnchor
{
    /// Returns a constraint between this anchor and another of the same type, with the given constraint type and constant.
    @objc func constraint(to anchor: NSLayoutAnchor<AnchorType>, type: ConstraintType, constant: CGFloat) -> NSLayoutConstraint
    {
        switch type
        {
        case .equalTo:
            return self.constraint(equalTo: anchor, constant: constant)
        case .lessThanOrEqualTo:
            return self.constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .greaterThanOrEqualTo:
            return self.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        }
    }
}

internal extension NSLayoutDimension
{
    /// Returns a constraint between this anchor and another of the same type, with the given constraint type, multiplier and constant.
    @objc func constraint(to anchor: NSLayoutDimension, type: ConstraintType, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    {
        switch type
        {
        case .equalTo:
            return self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
        case .lessThanOrEqualTo:
            return self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqualTo:
            return self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        }
    }
    
    /// Returns a constraint for this anchor with the given constraint type and constant.
    @objc func constraint(type: ConstraintType, constant: CGFloat) -> NSLayoutConstraint
    {
        switch type
        {
        case .equalTo:
            return self.constraint(equalToConstant: constant)
        case .lessThanOrEqualTo:
            return self.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqualTo:
            return self.constraint(greaterThanOrEqualToConstant: constant)
        }
    }
}
