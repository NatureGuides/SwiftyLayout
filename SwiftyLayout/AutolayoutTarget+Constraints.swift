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
    fileprivate func constrain(to other: AutolayoutTarget, priority: UILayoutPriority = .required, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraints(between: self, and: other) }
        self.activateConstraints(final, priority: priority)
        return final
    }
    
    /// Constrains this view to another using the given constraints.
    @discardableResult
    public func constrain(to other: AutolayoutTarget, priority: UILayoutPriority = .required, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        return self.constrain(to: other, priority: priority, constraints)
    }
    
    /// Constrains this view using the given constraints.
    @discardableResult
    fileprivate func constrain(priority: UILayoutPriority = .required, _ constraints: [UnaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraint(for: self) }
        self.activateConstraints(final, priority: priority)
        return final
    }
    
    /// Constrains this view using the given constraints.
    @discardableResult
    public func constrain(priority: UILayoutPriority = .required, _ constraints: UnaryConstraint...) -> [NSLayoutConstraint]
    {
        return self.constrain(priority: priority, constraints)
    }
    
    /// Activates the given constraints and sets `translatesAutoresizingMaskIntoConstraints` to `false` if possible.
    private func activateConstraints(_ constraints: [NSLayoutConstraint], priority: UILayoutPriority)
    {
        if let view = self.underlyingView
        {
            view.ifSafeSet(translatesAutoresizingMaskIntoConstraints: false)
        }
        for constraint in constraints
        {
            constraint.priority = priority
            constraint.isActive = true
        }
    }
}

extension AutolayoutTarget
{
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperview(priority: UILayoutPriority = .required, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperview(priority: UILayoutPriority = .required, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperviewLayoutMargins(priority: UILayoutPriority = .required, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.layoutMarginsGuide, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperviewLayoutMargins(priority: UILayoutPriority = .required, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.layoutMarginsGuide, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview's safe area using the given constraints.
    @available(iOS 11.0, *)
    @discardableResult
    public func constrainToSuperviewSafeArea(priority: UILayoutPriority = .required, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview's safe area using the given constraints.
    @available(iOS 11.0, *)
    @discardableResult
    public func constrainToSuperviewSafeArea(priority: UILayoutPriority = .required, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview's readable content guide using the given constraints.
    @discardableResult
    public func constrainToSuperviewReadableGuide(priority: UILayoutPriority = .required, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.readableContentGuide, priority: priority, constraints)
    }
    
    /// Constrains this view to its superview's readable content guide using the given constraints.
    @discardableResult
    public func constrainToSuperviewReadableGuide(priority: UILayoutPriority = .required, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.readableContentGuide, priority: priority, constraints)
    }
}
