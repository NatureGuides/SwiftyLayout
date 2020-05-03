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
    @discardableResult
    public func constrain(to other: AutolayoutTarget, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraints(between: self, and: other) }
        self.activateConstraints(final)
        return final
    }
    
    /// Constrains this view to another using the given constraint.
    @discardableResult
    public func constrain(to other: AutolayoutTarget, _ constraint: BinaryConstraint) -> [NSLayoutConstraint]
    {
        return self.constrain(to: other, [constraint])
    }
    
    /// Constrains this view using the given constraints.
    @discardableResult
    public func constrain(_ constraints: [UnaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.map{ $0.constraint(for: self) }
        self.activateConstraints(final)
        return final
    }
    
    /// Constrains this view using the given constraint.
    @discardableResult
    public func constrain(_ constraint: UnaryConstraint) -> NSLayoutConstraint
    {
        return self.constrain([constraint]).first!
    }
    
    /// Activate the given constraints and set `translatesAutoresizingMaskIntoConstraints` to `false` if possible.
    private func activateConstraints(_ constraints: [NSLayoutConstraint])
    {
        if let view = self.underlyingView
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

extension UIView
{
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperview(_ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, constraints)
    }
    
    /// Constrains this view to its superview using the given constraint.
    @discardableResult
    public func constrainToSuperview(_ constraint: BinaryConstraint) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, constraint)
    }
    
    /// Constrains this view to its superview's safe area using the given constraints.
    @available(iOS 11.0, *)
    @discardableResult
    public func constrainToSuperviewSafeArea(_ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, constraints)
    }
    
    /// Constrains this view to its superview's safe area using the given constraint.
    @available(iOS 11.0, *)
    @discardableResult
    public func constrainToSuperviewSafeArea(_ constraint: BinaryConstraint) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, constraint)
    }
}
