//
//  BinaryConstraint.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A constraint involving two views.
enum BinaryConstraint
{
    /// Constrains all four edges of one view to those of another, inset on each edge by a given value.
    case fill(inset: CGFloat)
    
    /// Constrains the leading edge of one view to that of another, inset by a given value.
    case leading(inset: CGFloat)
    
    /// Constrains the trailing edge of one view to that of another, inset by a given value.
    case trailing(inset: CGFloat)
    
    /// Constrains the top edge of one view to that of another, inset by a given value.
    case top(inset: CGFloat)
    
    /// Constrains the bottom edge of one view to that of another, inset by a given value.
    case bottom(inset: CGFloat)
    
    /// Constrains the width of one view to that of another, multiplied by a given value.
    case width(multiplier: CGFloat)
    
    /// Constrains the height of one view to that of another, multiplied by a given value
    case height(multiplier: CGFloat)
    
    /// Horizontally centers one view inside another.
    case horizontallyCentered
    
    /// Vertically centers one view inside another.
    case verticallyCentered
    
    /// Constrains all four edges of one view to those of another.
    static let fill: BinaryConstraint = { .fill(inset: 0) }()
    
    /// Constrains the leading edge of one view to that of another.
    static let leading: BinaryConstraint = { .leading(inset: 0) }()
    
    /// Constrains the trailing edge of one view to that of another.
    static let trailing: BinaryConstraint = { .trailing(inset: 0) }()
    
    /// Constrains the top edge of one view to that of another.
    static let top: BinaryConstraint = { .top(inset: 0) }()
    
    /// Constrains the bottom edge of one view to that of another.
    static let bottom: BinaryConstraint = { .bottom(inset: 0) }()
    
    /// Constrains the width of one view to that of another.
    static let width: BinaryConstraint = { .width(multiplier: 1) }()
    
    /// Constrains the height of one view to that of another.
    static let height: BinaryConstraint = { .height(multiplier: 1) }()
    
    /// Returns the multiple `NSLayoutConstraint` objects represented by this constraint, for the given two views.
    func constraints(between lhs: AutolayoutTarget, and rhs: AutolayoutTarget) -> [NSLayoutConstraint]
    {
        switch self
        {
        case .fill(let inset):
            var constraints = [NSLayoutConstraint]()
            constraints.append(lhs.leadingAnchor.constraint(equalTo: rhs.leadingAnchor, constant: inset))
            constraints.append(lhs.trailingAnchor.constraint(equalTo: rhs.trailingAnchor, constant: inset))
            constraints.append(lhs.topAnchor.constraint(equalTo: rhs.topAnchor, constant: inset))
            constraints.append(lhs.bottomAnchor.constraint(equalTo: rhs.bottomAnchor, constant: inset))
            return constraints
        case .leading(let inset):
            return [lhs.leadingAnchor.constraint(equalTo: rhs.leadingAnchor, constant: inset)]
        case .trailing(let inset):
            return [lhs.trailingAnchor.constraint(equalTo: rhs.trailingAnchor, constant: inset)]
        case .top(let inset):
            return [lhs.topAnchor.constraint(equalTo: rhs.topAnchor, constant: inset)]
        case .bottom(let inset):
            return [lhs.bottomAnchor.constraint(equalTo: rhs.bottomAnchor, constant: inset)]
        case .width(let multiplier):
            return [lhs.widthAnchor.constraint(equalTo: rhs.widthAnchor, multiplier: multiplier)]
        case .height(let multiplier):
            return [lhs.heightAnchor.constraint(equalTo: rhs.heightAnchor, multiplier: multiplier)]
        case .horizontallyCentered:
            return [lhs.centerXAnchor.constraint(equalTo: rhs.centerXAnchor)]
        case .verticallyCentered:
            return [lhs.centerYAnchor.constraint(equalTo: rhs.centerYAnchor)]
        }
    }
}
