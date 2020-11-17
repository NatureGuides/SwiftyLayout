//
//  BinaryConstraint+Kind.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

extension BinaryConstraint
{
    public enum Kind
    {
        case leading(type: ConstraintType)
        case trailing(type: ConstraintType)
        case top(type: ConstraintType)
        case bottom(type: ConstraintType)
        case horizontallyCentered
        case verticallyCentered
        case width(type: ConstraintType)
        case height(type: ConstraintType)
        
        public static var leading: Kind { self.leading(type: .equalTo) }
        public static var trailing: Kind { self.trailing(type: .equalTo) }
        public static var top: Kind { self.top(type: .equalTo) }
        public static var bottom: Kind { self.bottom(type: .equalTo) }
        public static var width: Kind { self.width(type: .equalTo) }
        public static var height: Kind { self.height(type: .equalTo) }
        
        func with(value: CGFloat) -> BinaryConstraint
        {
            switch self
            {
            case .leading(let type):
                return .leading(inset: value, type)
            case .trailing(let type):
                return .trailing(inset: value, type)
            case .top(let type):
                return .top(inset: value, type)
            case .bottom(let type):
                return .bottom(inset: value, type)
            case .horizontallyCentered:
                return .horizontallyCentered
            case .verticallyCentered:
                return .verticallyCentered
            case .width(let type):
                return .width(constant: value, type)
            case .height(let type):
                return .height(constant: value, type)
            }
        }
    }
}

