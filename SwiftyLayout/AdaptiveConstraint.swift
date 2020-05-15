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
    /// Constrains the given view by different constraints in horizontally regular and horizontally compact environments.
    public static func horizontally(regular: UnaryConstraint, compact: UnaryConstraint, for view: UIView) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constraint: UnaryConstraint
            switch traitCollection.horizontalSizeClass
            {
            case .regular, .unspecified:
                constraint = regular
            case .compact:
                constraint = compact
            @unknown default:
                constraint = regular
            }
            return view.constrain(constraint)
        }
    }
    
    /// Constrains between the two given views by different constraints in horizontally regular and horizontally compact environments.
    public static func horizontally(regular: BinaryConstraint, compact: BinaryConstraint, between view: UIView, and other: AutolayoutTarget) -> AdaptiveConstraint
    {
        AdaptiveConstraint(view: view) { traitCollection in
            let constraint: BinaryConstraint
            switch traitCollection.horizontalSizeClass
            {
            case .regular, .unspecified:
                constraint = regular
            case .compact:
                constraint = compact
            @unknown default:
                constraint = regular
            }
            return view.constrain(to: other, constraint)
        }
    }
    
    /// The view to apply the given constraints to.
    let view: UIView
    
    /// Should return the correct constraints for the given trait collection.
    let constraintsForTraitCollection: (UITraitCollection) -> [NSLayoutConstraint]
    
    /// The currently applied constraints; when this is changed the previous constraints will be automatically removed.
    private var currentConstraints: [NSLayoutConstraint]
    {
        willSet
        {
            self.view.removeConstraints(self.currentConstraints)
        }
    }
    
    public init(view: UIView, constraintsForTraitCollection: @escaping (UITraitCollection) -> [NSLayoutConstraint])
    {
        self.view = view
        self.constraintsForTraitCollection = constraintsForTraitCollection
        self.currentConstraints = self.constraintsForTraitCollection(self.view.traitCollection)
        super.init()
    }
    
    /// Notifies the constraint that the view's trait collection has changed.
    /// - Note: This **must** be called by the relevant view every time the trait collection changes.
    public func traitCollectionDidChange()
    {
        self.currentConstraints = self.constraintsForTraitCollection(self.view.traitCollection)
    }
}
