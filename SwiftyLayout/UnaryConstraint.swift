//
//  UnaryConstraint.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A constraint involving only one view.
enum UnaryConstraint
{
    /// Constrains a view to a given width.
    case width(_ value: CGFloat)
    
    /// Constrains a view to a given height.
    case height(_ value: CGFloat)
    
    /// Constrains a view to a given aspect ratio.
    case aspectRatio(_ value: CGFloat)
    
    /// Returns the single `NSLayoutConstraint` object represented by this constraint, for the given view.
    func constraint(for view: UIView) -> NSLayoutConstraint
    {
        switch self
        {
        case .width(let value):
            return view.widthAnchor.constraint(equalToConstant: value)
        case .height(let value):
            return view.heightAnchor.constraint(equalToConstant: value)
        case .aspectRatio(let value):
            return view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: value)
        }
    }
}
