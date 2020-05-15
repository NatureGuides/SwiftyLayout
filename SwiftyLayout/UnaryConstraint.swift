//
//  UnaryConstraint.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A constraint involving only one view.
public enum UnaryConstraint
{
    /// A type to apply to unary constraints.
    public enum Kind
    {
        case equalTo, greaterThan, lessThan
    }
    
    /// Constrains a view to a given width.
    case width(_ value: CGFloat, _ kind: Kind)
    
    /// Constrains a view to a given height.
    case height(_ value: CGFloat, _ kind: Kind)
    
    /// Constrains a view to a given size.
    case size(_ value: CGSize, _ kind: Kind)
    
    /// Constrains a view to a given aspect ratio.
    case aspectRatio(_ value: CGFloat, _ kind: Kind)
    
    /// Constrains a view to a given width.
    public static func width(_ value: CGFloat) -> UnaryConstraint
    {
        .width(value, .equalTo)
    }
    
    /// Constrains a view to a given height.
    public static func height(_ value: CGFloat) -> UnaryConstraint
    {
        .height(value, .equalTo)
    }
    
    /// Constrains a view to a given size.
    public static func size(_ value: CGSize) -> UnaryConstraint
    {
        .size(value, .equalTo)
    }
    
    /// Constrains a view to a given aspect ratio.
    public static func aspectRatio(_ value: CGFloat) -> UnaryConstraint
    {
        .aspectRatio(value, .equalTo)
    }
    
    /// Constrains a view to a square aspect ratio.
    public static let squareAspectRatio: UnaryConstraint = { .aspectRatio(1, .equalTo) }()
    
    /// Returns the `NSLayoutConstraint` objects represented by this constraint, for the given view.
    internal func constraint(for target: AutolayoutTarget) -> [NSLayoutConstraint]
    {
        switch self
        {
        case .width(let value, let kind):
            switch kind
            {
            case .equalTo:
                return [target.widthAnchor.constraint(equalToConstant: value)]
            case .greaterThan:
                return [target.widthAnchor.constraint(greaterThanOrEqualToConstant: value)]
            case .lessThan:
                return [target.widthAnchor.constraint(lessThanOrEqualToConstant: value)]
            }
        case .height(let value, let kind):
            switch kind
            {
            case .equalTo:
                return [target.heightAnchor.constraint(equalToConstant: value)]
            case .greaterThan:
                return [target.heightAnchor.constraint(greaterThanOrEqualToConstant: value)]
            case .lessThan:
                return [target.heightAnchor.constraint(lessThanOrEqualToConstant: value)]
            }
        case .size(let value, let kind):
            switch kind
            {
            case .equalTo:
                let width = target.widthAnchor.constraint(equalToConstant: value.width)
                let height = target.heightAnchor.constraint(equalToConstant: value.height)
                return [width, height]
            case .greaterThan:
                let width = target.widthAnchor.constraint(greaterThanOrEqualToConstant: value.width)
                let height = target.heightAnchor.constraint(greaterThanOrEqualToConstant: value.height)
                return [width, height]
            case .lessThan:
                let width = target.widthAnchor.constraint(lessThanOrEqualToConstant: value.width)
                let height = target.heightAnchor.constraint(lessThanOrEqualToConstant: value.height)
                return [width, height]
            }
        case .aspectRatio(let value, let kind):
            switch kind
            {
            case .equalTo:
                return [target.widthAnchor.constraint(equalTo: target.heightAnchor, multiplier: value)]
            case .greaterThan:
                return [target.widthAnchor.constraint(greaterThanOrEqualTo: target.heightAnchor, multiplier: value)]
            case .lessThan:
                return [target.widthAnchor.constraint(lessThanOrEqualTo: target.heightAnchor, multiplier: value)]
            }
        }
    }
}
