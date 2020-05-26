//
//  Dimension.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 26/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

extension UIUserInterfaceSizeClass
{
    /// The dimension of a size class.
    public enum Dimension
    {
        case horiziontal, vertical
        
        /// The size class representing this dimension for the given trait collection.
        public func sizeClass(from traitCollection: UITraitCollection) -> UIUserInterfaceSizeClass
        {
            switch self
            {
            case .horiziontal:
                return traitCollection.horizontalSizeClass
            case .vertical:
                return traitCollection.horizontalSizeClass
            }
        }
        
        /// The size class representing this dimension for the given trait environment such as a `UIView`.
        public func sizeClass(from environment: UITraitEnvironment) -> UIUserInterfaceSizeClass
        {
            return self.sizeClass(from: environment.traitCollection)
        }
    }
}
