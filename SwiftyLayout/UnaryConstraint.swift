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
    /// Constrains a view to a given width.
    case width(_ value: CGFloat)
    
    /// Constrains a view to a given height.
    case height(_ value: CGFloat)
    
    /// Constrains a view to a given aspect ratio.
    case aspectRatio(_ value: CGFloat)
    
    /// Constrains a view to a square aspect ratio.
    public static let squareAspectRatio: UnaryConstraint = { .aspectRatio(1) }()
    
    /// Returns the single `NSLayoutConstraint` object represented by this constraint, for the given view.
    internal func constraint(for target: AutolayoutTarget) -> NSLayoutConstraint
    {
        switch self
        {
        case .width(let value):
            return target.widthAnchor.constraint(equalToConstant: value)
        case .height(let value):
            return target.heightAnchor.constraint(equalToConstant: value)
        case .aspectRatio(let value):
            return target.widthAnchor.constraint(equalTo: target.heightAnchor, multiplier: value)
        }
    }
}
