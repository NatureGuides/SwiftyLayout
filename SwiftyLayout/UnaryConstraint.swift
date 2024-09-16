//
//  UnaryConstraint.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A constraint involving only one view.
public enum UnaryConstraint: Sendable
{
    /// Constrains a view to a given width.
    case width(_ value: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains a view to a given height.
    case height(_ value: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains a view to a given size.
    case size(_ value: CGSize, _ type: ConstraintType = .equalTo)
    
    /// Constrains a view to a given aspect ratio.
    case aspectRatio(_ value: CGFloat, _ type: ConstraintType = .equalTo)
    
    /// Constrains a view to a square aspect ratio.
    public static let squareAspectRatio: UnaryConstraint = { .aspectRatio(1, .equalTo) }()
    
    /// Returns the `NSLayoutConstraint` objects represented by this constraint, for the given view.
    @MainActor public func constraint(for target: AutolayoutTarget) -> [NSLayoutConstraint]
    {
        switch self
        {
        case .width(let value, let type):
            return [target.widthAnchor.constraint(type: type, constant: value)]
        case .height(let value, let type):
            return [target.heightAnchor.constraint(type: type, constant: value)]
        case .size(let value, let type):
            let width = target.widthAnchor.constraint(type: type, constant: value.width)
            let height = target.heightAnchor.constraint(type: type, constant: value.height)
            return [width, height]
        case .aspectRatio(let value, let type):
            return [target.widthAnchor.constraint(to: target.heightAnchor, type: type, multiplier: value, constant: 0)]
        }
    }
}
