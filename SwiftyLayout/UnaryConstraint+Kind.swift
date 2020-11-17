//
//  UnaryConstraint+Kind.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

extension UnaryConstraint
{
    public enum Kind
    {
        case width(type: ConstraintType)
        case height(type: ConstraintType)
        case size(type: ConstraintType)
        case aspectRatio(type: ConstraintType)
        
        public static var width: Kind { self.width(type: .equalTo) }
        public static var height: Kind { self.height(type: .equalTo) }
        public static var size: Kind { self.size(type: .equalTo) }
        public static var aspectRatio: Kind { self.aspectRatio(type: .equalTo) }
        
        func with(value: CGFloat) -> UnaryConstraint
        {
            switch self
            {
            case .width(let type):
                return .width(value, type)
            case .height(let type):
                return .height(value, type)
            case .size(let type):
                let size = CGSize(width: value, height: value)
                return .size(size, type)
            case .aspectRatio(let type):
                return .aspectRatio(value, type)
            }
        }
    }
}
