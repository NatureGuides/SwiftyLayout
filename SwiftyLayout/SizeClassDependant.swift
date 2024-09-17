//
//  SizeClassDependant.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 26/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// Represents a value that changes depending on a given size class.
public struct SizeClassDependant<T>
{
    public init(regular: T, compact: T, dimension: UIUserInterfaceSizeClass.Dimension = .horiziontal)
    {
        self.regular = regular
        self.compact = compact
        self.dimension = dimension
    }
    
    /// The value to use for regular or unknown size classes.
    public var regular: T
    
    /// The value to use for compact size classes.
    
    public var compact: T
    
    /// The dimension to use when calculating the current value; defaults to `.horizontal`.
    public var dimension: UIUserInterfaceSizeClass.Dimension
    
    /// The value for the given trait environment, such as `UIView`.
    @MainActor public func value(for environment: UITraitEnvironment) -> T
    {
        self.value(for: environment.traitCollection)
    }
    
    /// The value for the given trait collection.
    public func value(for traitCollection: UITraitCollection) -> T
    {
        let sizeClass = self.dimension.sizeClass(from: traitCollection)
        return self.value(for: sizeClass)
    }
    
    /// The value for the given size class.
    public func value(for sizeClass: UIUserInterfaceSizeClass) -> T
    {
        switch sizeClass
        {
        case .regular, .unspecified:
            return self.regular
        case .compact:
            return self.compact
        @unknown default:
            return self.regular
        }
    }
}

extension SizeClassDependant: Sendable where T: Sendable { }
