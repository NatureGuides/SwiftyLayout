//
//  AdaptiveConstraint.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A UI constraint that adapts to `UITraitCollection` changes.
/// - Note: `traitCollectionDidChange` **must** be called by the relevant view every time the trait collection changes.
public class AdaptiveConstraint: NSObject
{
    public static func `for`(_ view: UIView, _ kind: UnaryConstraint.Kind, _ value: SizeClassDependant<CGFloat>, dimension: UIUserInterfaceSizeClass.Dimension = .horiziontal, priority: UILayoutPriority = .required) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constant = value.value(for: traitCollection)
            let constraint = kind.with(value: constant)
            return view.constrain(priority: priority, constraint)
        }
    }
    
    /// Constrains the given view by different constraints in regular and compact environments.
    public static func `for`(_ view: UIView, regular: UnaryConstraint, compact: UnaryConstraint, dimension: UIUserInterfaceSizeClass.Dimension = .horiziontal, priority: UILayoutPriority = .required) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constraint: UnaryConstraint
            switch dimension.sizeClass(from: traitCollection)
            {
            case .regular, .unspecified:
                constraint = regular
            case .compact:
                constraint = compact
            @unknown default:
                constraint = regular
            }
            return view.constrain(priority: priority, constraint)
        }
    }
    
    public static func between(_ view: UIView, and otherView: AutolayoutTarget, _ kind: BinaryConstraint.Kind, _ value: SizeClassDependant<CGFloat>, dimension: UIUserInterfaceSizeClass.Dimension = .horiziontal, priority: UILayoutPriority = .required) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constant = value.value(for: traitCollection)
            let constraint = kind.with(value: constant)
            return view.constrain(to: otherView, priority: priority, constraint)
        }
    }
    
    public static func fillBetween(_ view: UIView, and otherView: AutolayoutTarget, _ kind: BinaryConstraint.Kind, _ value: SizeClassDependant<UIEdgeInsets>, dimension: UIUserInterfaceSizeClass.Dimension = .horiziontal, priority: UILayoutPriority = .required) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constant = value.value(for: traitCollection)
            return view.constrain(to: otherView, .fill(insets: constant))
        }
    }
    
    /// Constrains between the two given views by different constraints in regular and compact environments.
    public static func between(_ view: UIView, and otherView: AutolayoutTarget, regular: BinaryConstraint, compact: BinaryConstraint, dimension: UIUserInterfaceSizeClass.Dimension = .horiziontal, priority: UILayoutPriority = .required) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constraint: BinaryConstraint
            switch dimension.sizeClass(from: traitCollection)
            {
            case .regular, .unspecified:
                constraint = regular
            case .compact:
                constraint = compact
            @unknown default:
                constraint = regular
            }
            return view.constrain(to: otherView, priority: priority, constraint)
        }
    }
    
    @available(iOS 11.0, *)
    public static func scale(_ constraint: UnaryConstraint, priority: UILayoutPriority = .required, with textStyle: UIFont.TextStyle, for view: UIView) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let scaledConstraint = constraint.scaled(by: textStyle)
            return view.constrain(priority: priority, scaledConstraint)
        }
    }
    
    /// The view to apply the given constraints to.
    let view: UIView
    
    /// Should return the correct constraints for the given trait collection.
    let constraintsForTraitCollection: (UITraitCollection) -> [NSLayoutConstraint]
    
    /// The currently applied constraints; when this is changed the previous constraints will be automatically removed.
    private var currentConstraints: [NSLayoutConstraint]
    {
        didSet
        {
            self.view.removeConstraints(oldValue)
            for constraint in self.currentConstraints
            {
                constraint.isActive = true
            }
            self.currentConstraints.forEach{ $0.isActive = true }
        }
    }
    
    public init(view: UIView, constraintsForTraitCollection: @escaping (UITraitCollection) -> [NSLayoutConstraint])
    {
        self.view = view
        self.view.ifSafeSet(translatesAutoresizingMaskIntoConstraints: false)
        self.constraintsForTraitCollection = constraintsForTraitCollection
        self.currentConstraints = self.constraintsForTraitCollection(self.view.traitCollection)
        self.currentConstraints.forEach{ $0.isActive = true }
        super.init()
    }
    
    /// Notifies the constraint that the view's trait collection has changed.
    /// - Note: This **must** be called by the relevant view every time the trait collection changes.
    public func traitCollectionDidChange()
    {
        self.currentConstraints.removeAll()
        self.currentConstraints = self.constraintsForTraitCollection(self.view.traitCollection)
    }
}

extension UnaryConstraint
{
    @available(iOS 11.0, *)
    func scaled(by textStyle: UIFont.TextStyle, compatibleWith traitCollection: UITraitCollection? = nil) -> UnaryConstraint
    {
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        switch self
        {
        case .width(let value, let type):
            let scaledValue = metrics.scaledValue(for: value, compatibleWith: traitCollection)
            return .width(scaledValue, type)
        case .height(let value, let type):
            let scaledValue = metrics.scaledValue(for: value, compatibleWith: traitCollection)
            return .height(scaledValue, type)
        case .size(let value, let type):
            let scaledWidth = metrics.scaledValue(for: value.width, compatibleWith: traitCollection)
            let scaledHeight = metrics.scaledValue(for: value.height, compatibleWith: traitCollection)
            let scaledValue = CGSize(width: scaledWidth, height: scaledHeight)
            return .size(scaledValue, type)
        case .aspectRatio(let value, let type):
            let scaledValue = metrics.scaledValue(for: value, compatibleWith: traitCollection)
            return .aspectRatio(scaledValue, type)
        }
    }
}
