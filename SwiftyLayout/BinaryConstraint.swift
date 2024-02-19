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
    /// Constrains all four edges of one view to those of another, inset on each edge by a given value.
    case fill(insets: UIEdgeInsets)
    
    /// Constrains the leading edge of one view to that of another, inset by a given value.
    case leading(inset: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains the trailing edge of one view to that of another, inset by a given value.
    case trailing(inset: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains the leading and trailing edges of one view to those of another, inset by a given value.
    case horizontal(inset: CGFloat, type: ConstraintType = .equalTo)
    
    /// Constrains the top edge of one view to that of another, inset by a given value.
    case top(inset: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains the bottom edge of one view to that of another, inset by a given value.
    case bottom(inset: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains the top and bottom edges of one view to those of another, inset by a given value.
    case vertical(inset: CGFloat, type: ConstraintType = .equalTo)
    
    /// Constraints the top of one view to the bottom of another, padded by a given value.
    case verticalSpacingTop(_: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constraints the bottom of one view to the top of another, padded by a given value.
    case verticalSpacingBottom(_: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constraints the leading edge of one view to the trailing edge of another, padded by a given value.
    case horizontalSpacingLeading(_: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constraints the trailing edge of one view to the leading edge of another, padded by a given value.
    case horizontalSpacingTrailing(_: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains the width of one view to that of another, altered by the given multiplier and constant.
    case width(multiplier: CGFloat = 1, constant: CGFloat = 0, _ type: ConstraintType = .equalTo)
    
    /// Constrains the height of one view to that of another, altered by the given multiplier and constant.
    case height(multiplier: CGFloat = 1, constant: CGFloat = 0, _ type: ConstraintType = .equalTo)
    
    /// Constrains the width and height of one view to that of another, altered by the given multiplier and constant.
    case size(multiplier: CGFloat = 1, constant: CGSize = .zero, _ type: ConstraintType = .equalTo)
    
    /// Horizontally centers one view inside another, offset by the given amount.
    case horizontallyCentered(offset: CGFloat)
    
    /// Vertically centers one view inside another, offset by the given amount.
    case verticallyCentered(offset: CGFloat)
    
    /// Horizontally and vertically centers one view inside another.
    case centered
    
    /// Constrains all four edges of one view to those of another, using the given inset for each edge.
    public static func fill(inset: CGFloat) -> BinaryConstraint
    {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return .fill(insets: insets)
    }
    
    /// Constrains all four edges of one view to those of another.
    public static let fill: BinaryConstraint = { .fill(insets: .zero) }()
    
    /// Constrains the leading edge of one view to that of another.
    public static let leading: BinaryConstraint = { .leading(inset: 0) }()
    
    /// Constrains the trailing edge of one view to that of another.
    public static let trailing: BinaryConstraint = { .trailing(inset: 0) }()
    
    /// Constrains the leading and trailing edges of one view to those of another.
    public static let horizontal: BinaryConstraint = { .horizontal(inset: 0) }()
    
    /// Constrains the top edge of one view to that of another.
    public static let top: BinaryConstraint = { .top(inset: 0) }()
    
    /// Constrains the bottom edge of one view to that of another.
    public static let bottom: BinaryConstraint = { .bottom(inset: 0) }()
    
    /// Constrains the top and bottom edges of one view to those of another.
    public static let vertical: BinaryConstraint = { .vertical(inset: 0) }()
    
    /// Constraints the top of one view to the bottom of another.
    public static let verticalSpacingTop: BinaryConstraint = { .verticalSpacingTop(0) }()
    
    /// Constraints the bottom of one view to the top of another.
    public static let verticalSpacingBottom: BinaryConstraint = { .verticalSpacingBottom(0) }()
    
    /// Constraints the leading edge of one view to the trailing edge of another.
    public static let horizontalSpacingLeading: BinaryConstraint = { .horizontalSpacingLeading(0) }()
    
    /// Constraints the trailing edge of one view to the leading edge of another.
    public static let horizontalSpacingTrailing: BinaryConstraint = { .horizontalSpacingTrailing(0) }()
    
    /// Constrains the width of one view to that of another.
    public static let width: BinaryConstraint = { .width() }()
    
    /// Constrains the height of one view to that of another.
    public static let height: BinaryConstraint = { .height() }()
    
    /// Constrains the width and height of one view to that of another.
    public static let size: BinaryConstraint = { .size() }()
    
    /// Horizontally centers one view inside another.
    public static let horizontallyCentered = BinaryConstraint.horizontallyCentered(offset: 0)
    
    /// Vertically centers one view inside another.
    public static let verticallyCentered = BinaryConstraint.verticallyCentered(offset: 0)
    
    /// Returns the multiple `NSLayoutConstraint` objects represented by this constraint, for the given two views.
    public func constraints(between lhs: AutolayoutTarget, and rhs: AutolayoutTarget) -> [NSLayoutConstraint]
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
        case .leading(let inset, let type):
            return [lhs.leadingAnchor.constraint(to: rhs.leadingAnchor, type: type, constant: inset)]
        case .trailing(let inset, let type):
            return [lhs.trailingAnchor.constraint(to: rhs.trailingAnchor, type: type, constant: -inset)]
        case .horizontal(let inset, let type):
            return [lhs.leadingAnchor.constraint(to: rhs.leadingAnchor, type: type, constant: -inset), lhs.trailingAnchor.constraint(to: rhs.trailingAnchor, type: type, constant: -inset)]
        case .top(let inset, let type):
            return [lhs.topAnchor.constraint(to: rhs.topAnchor, type: type, constant: inset)]
        case .bottom(let inset, let type):
            return [lhs.bottomAnchor.constraint(to: rhs.bottomAnchor, type: type, constant: -inset)]
        case .vertical(let inset, let type):
            return [lhs.topAnchor.constraint(to: rhs.topAnchor, type: type, constant: -inset), lhs.bottomAnchor.constraint(to: rhs.bottomAnchor, type: type, constant: -inset)]
        case .verticalSpacingTop(let padding, let type):
            return [lhs.topAnchor.constraint(to: rhs.bottomAnchor, type: type, constant: padding)]
        case .verticalSpacingBottom(let padding, let type):
            return [lhs.bottomAnchor.constraint(to: rhs.topAnchor, type: type, constant: padding)]
        case .horizontalSpacingLeading(let padding, let type):
            return [lhs.leadingAnchor.constraint(to: rhs.trailingAnchor, type: type, constant: padding)]
        case .horizontalSpacingTrailing(let padding, let type):
            return [lhs.trailingAnchor.constraint(to: rhs.leadingAnchor, type: type, constant: padding)]
        case .width(let multiplier, let constant, let type):
            return [lhs.widthAnchor.constraint(to: rhs.widthAnchor, type: type, multiplier: multiplier, constant: constant)]
        case .height(let multiplier, let constant, let type):
            return [lhs.heightAnchor.constraint(to: rhs.heightAnchor, type: type, multiplier: multiplier, constant: constant)]
        case .size(let multiplier, let constant, let type):
            return [lhs.heightAnchor.constraint(to: rhs.heightAnchor, type: type, multiplier: multiplier, constant: constant.height), lhs.widthAnchor.constraint(to: rhs.widthAnchor, type: type, multiplier: multiplier, constant: constant.width)]
        case .horizontallyCentered(let offset):
            return [lhs.centerXAnchor.constraint(equalTo: rhs.centerXAnchor, constant: offset)]
        case .verticallyCentered(let offset):
            return [lhs.centerYAnchor.constraint(equalTo: rhs.centerYAnchor, constant: offset)]
        case .centered:
            return [lhs.centerXAnchor.constraint(equalTo: rhs.centerXAnchor),
                    lhs.centerYAnchor.constraint(equalTo: rhs.centerYAnchor)]
        }
    }
}
