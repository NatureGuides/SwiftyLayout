//
//  AutolayoutTarget+Constraints.swift
//  AutolayoutHelpers
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Classical Apps. All rights reserved.
//

import UIKit

extension AutolayoutTarget
{
    /// Constrains this view to another using the given constraints.
    public func constrain(to other: AutolayoutTarget, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraints(between: self, and: other) }
        self.activateConstraints(final)
        return final
    }
    
    /// Constrains this view using the given constraints.
    public func constrain(_ constraints: [UnaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.map{ $0.constraint(for: self) }
        self.activateConstraints(final)
        return final
    }
    
    /// Activate the given constraints and, if `self` is a view, set `translatesAutoresizingMaskIntoConstraints` to `false`.
    private func activateConstraints(_ constraints: [NSLayoutConstraint])
    {
        if let view = self as? UIView
        {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints(constraints)
        }
        else
        {
            for constraint in constraints
            {
                constraint.isActive = true
            }
        }
    }
}
