//
//  UIView+Constraints.swift
//  AutolayoutHelpers
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Classical Apps. All rights reserved.
//

import UIKit

extension UIView
{
    /// Constrains this view to another using the given constraints.
    func constrain(to otherView: UIView, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraints(between: self, and: otherView) }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(final)
        return final
    }
    
    /// Constrains this view using the given constraints.
    func constrain(_ constraints: UnaryConstraint...) -> [NSLayoutConstraint]
    {
        let final = constraints.map{ $0.constraint(for: self) }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(final)
        return final
    }
}

