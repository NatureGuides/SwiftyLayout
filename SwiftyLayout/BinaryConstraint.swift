//
//  BinaryConstraint.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A constraint involving two views.
public enum BinaryConstraint
{
    /// A type to apply to binary constraints.
    public enum Kind
    {
        case equalTo, greaterThan, lessThan
    }
    
    /// Constrains all four edges of one view to those of another, inset on each edge by a given value.
    case fill(insets: UIEdgeInsets)
    
    /// Constrains the leading edge of one view to that of another, inset by a given value.
    case leading(inset: CGFloat, kind: Kind)
    
    /// Constrains the trailing edge of one view to that of another, inset by a given value.
    case trailing(inset: CGFloat, kind: Kind)
    
    /// Constrains the top edge of one view to that of another, inset by a given value.
    case top(inset: CGFloat, kind: Kind)
    
    /// Constrains the bottom edge of one view to that of another, inset by a given value.
    case bottom(inset: CGFloat, kind: Kind)
    
    /// Constrains the width of one view to that of another, altered by the given multiplier and constant.
    case width(multiplier: CGFloat, constant: CGFloat, kind: Kind)
    
    /// Constrains the height of one view to that of another, altered by the given multiplier and constant.
    case height(multiplier: CGFloat, constant: CGFloat, kind: Kind)
    
    /// Horizontally centers one view inside another.
    case horizontallyCentered
    
    /// Vertically centers one view inside another.
    case verticallyCentered
    
    public static func fill(inset: CGFloat) -> BinaryConstraint
    {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return .fill(insets: insets)
    }
    
    /// Constrains all four edges of one view to those of another.
    public static let fill: BinaryConstraint = { .fill(insets: .zero) }()
    
    /// Constrains the leading edge of one view to that of another.
    public static func leading(inset: CGFloat) -> BinaryConstraint
    {
        .leading(inset: inset, kind: .equalTo)
    }
    
    /// Constrains the leading edge of one view to that of another.
    public static let leading: BinaryConstraint = { .leading(inset: 0, kind: .equalTo) }()
    
    /// Constrains the leading edge of one view to that of another.
    public static func trailing(inset: CGFloat) -> BinaryConstraint
    {
        .trailing(inset: inset, kind: .equalTo)
    }
    
    /// Constrains the trailing edge of one view to that of another.
    public static let trailing: BinaryConstraint = { .trailing(inset: 0, kind: .equalTo) }()
    
    /// Constrains the top edge of one view to that of another.
    public static func top(inset: CGFloat) -> BinaryConstraint
    {
        .top(inset: inset, kind: .equalTo)
    }
    
    /// Constrains the top edge of one view to that of another.
    public static let top: BinaryConstraint = { .top(inset: 0, kind: .equalTo) }()
    
    /// Constrains the bottom edge of one view to that of another.
    public static func bottom(inset: CGFloat) -> BinaryConstraint
    {
        .bottom(inset: inset, kind: .equalTo)
    }
    
    /// Constrains the bottom edge of one view to that of another.
    public static let bottom: BinaryConstraint = { .bottom(inset: 0, kind: .equalTo) }()
    
    /// Constrains the width of one view to that of another.
    public static let width: BinaryConstraint = { .width(multiplier: 1, constant: 0, kind: .equalTo) }()
    
    /// Constrains the width of one view to that of another, altered by the given multiplier.
    public static func width(multiplier: CGFloat, kind: Kind = .equalTo) -> BinaryConstraint
    {
        .width(multiplier: multiplier, constant: 0, kind: kind)
    }
    
    /// Constrains the width of one view to that of another, altered by the given constant .
    public static func width(constant: CGFloat, kind: Kind = .equalTo) -> BinaryConstraint
    {
        .width(multiplier: 1, constant: constant, kind: kind)
    }
    
    /// Constrains the height of one view to that of another.
    public static let height: BinaryConstraint = { .height(multiplier: 1, constant: 0, kind: .equalTo) }()
    
    /// Constrains the height of one view to that of another, altered by the given multiplier .
    public static func height(multiplier: CGFloat, kind: Kind = .equalTo) -> BinaryConstraint
    {
        .height(multiplier: multiplier, constant: 0, kind: kind)
    }
    
    /// Constrains the height of one view to that of another, altered by the given constant .
    public static func height(constant: CGFloat, kind: Kind = .equalTo) -> BinaryConstraint
    {
        .height(multiplier: 1, constant: constant, kind: kind)
    }
    
    /// Returns the multiple `NSLayoutConstraint` objects represented by this constraint, for the given two views.
    internal func constraints(between lhs: AutolayoutTarget, and rhs: AutolayoutTarget) -> [NSLayoutConstraint]
    {
        switch self
        {
        case .fill(let insets):
            var constraints = [NSLayoutConstraint]()
            constraints.append(lhs.leadingAnchor.constraint(equalTo: rhs.leadingAnchor, constant: insets.left))
            constraints.append(lhs.trailingAnchor.constraint(equalTo: rhs.trailingAnchor, constant: -insets.right))
            constraints.append(lhs.topAnchor.constraint(equalTo: rhs.topAnchor, constant: insets.top))
            constraints.append(lhs.bottomAnchor.constraint(equalTo: rhs.bottomAnchor, constant: -insets.bottom))
            return constraints
        case .leading(let inset, let kind):
            switch kind
            {
            case .equalTo:
                return [lhs.leadingAnchor.constraint(equalTo: rhs.leadingAnchor, constant: inset)]
            case .lessThan:
                return [lhs.leadingAnchor.constraint(lessThanOrEqualTo: rhs.leadingAnchor, constant: inset)]
            case .greaterThan:
                return [lhs.leadingAnchor.constraint(greaterThanOrEqualTo: rhs.leadingAnchor, constant: inset)]
            }
        case .trailing(let inset, let kind):
            switch kind
            {
            case .equalTo:
                return [lhs.trailingAnchor.constraint(equalTo: rhs.trailingAnchor, constant: -inset)]
            case .lessThan:
                return [lhs.trailingAnchor.constraint(lessThanOrEqualTo: rhs.trailingAnchor, constant: -inset)]
            case .greaterThan:
                return [lhs.trailingAnchor.constraint(greaterThanOrEqualTo: rhs.trailingAnchor, constant: -inset)]
            }
        case .top(let inset, let kind):
            switch kind
            {
            case .equalTo:
                return [lhs.topAnchor.constraint(equalTo: rhs.topAnchor, constant: inset)]
            case .lessThan:
                return [lhs.topAnchor.constraint(lessThanOrEqualTo: rhs.topAnchor, constant: inset)]
            case .greaterThan:
                return [lhs.topAnchor.constraint(greaterThanOrEqualTo: rhs.topAnchor, constant: inset)]
            }
        case .bottom(let inset, let kind):
            switch kind
            {
            case .equalTo:
                return [lhs.bottomAnchor.constraint(equalTo: rhs.bottomAnchor, constant: -inset)]
            case .lessThan:
                return [lhs.bottomAnchor.constraint(lessThanOrEqualTo: rhs.bottomAnchor, constant: -inset)]
            case .greaterThan:
                return [lhs.bottomAnchor.constraint(greaterThanOrEqualTo: rhs.bottomAnchor, constant: -inset)]
            }
        case .width(let multiplier, let constant, let kind):
            switch kind
            {
            case .equalTo:
                return [lhs.widthAnchor.constraint(equalTo: rhs.widthAnchor, multiplier: multiplier, constant: constant)]
            case .lessThan:
                return [lhs.widthAnchor.constraint(lessThanOrEqualTo: rhs.widthAnchor, multiplier: multiplier, constant: constant)]
            case .greaterThan:
                return [lhs.widthAnchor.constraint(greaterThanOrEqualTo: rhs.widthAnchor, multiplier: multiplier, constant: constant)]
            }
        case .height(let multiplier, let constant, let kind):
            switch kind
            {
            case .equalTo:
                return [lhs.heightAnchor.constraint(equalTo: rhs.heightAnchor, multiplier: multiplier, constant: constant)]
            case .lessThan:
                return [lhs.heightAnchor.constraint(lessThanOrEqualTo: rhs.heightAnchor, multiplier: multiplier, constant: constant)]
            case .greaterThan:
                return [lhs.heightAnchor.constraint(greaterThanOrEqualTo: rhs.heightAnchor, multiplier: multiplier, constant: constant)]
            }
        case .horizontallyCentered:
            return [lhs.centerXAnchor.constraint(equalTo: rhs.centerXAnchor)]
        case .verticallyCentered:
            return [lhs.centerYAnchor.constraint(equalTo: rhs.centerYAnchor)]
        }
    }
}
