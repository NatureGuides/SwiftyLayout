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
        case verticalSpacingTop(type: ConstraintType)
        case verticalSpacingBottom(type: ConstraintType)
        case horizontalSpacingLeading(type: ConstraintType)
        case horizontalSpacingTrailing(type: ConstraintType)
        
        public static var leading: Kind { self.leading(type: .equalTo) }
        public static var trailing: Kind { self.trailing(type: .equalTo) }
        public static var top: Kind { self.top(type: .equalTo) }
        public static var bottom: Kind { self.bottom(type: .equalTo) }
        public static var width: Kind { self.width(type: .equalTo) }
        public static var height: Kind { self.height(type: .equalTo) }
        public static var verticalSpacingTop: Kind { self.verticalSpacingTop(type: .equalTo) }
        public static var verticalSpacingBottom: Kind { self.verticalSpacingBottom(type: .equalTo) }
        public static var horizontalSpacingLeading: Kind { self.horizontalSpacingLeading(type: .equalTo) }
        public static var horizontalSpacingTrailing: Kind { self.horizontalSpacingTrailing(type: .equalTo) }
        
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
            case .verticalSpacingTop(let type):
                return .verticalSpacingTop(value, type)
            case .verticalSpacingBottom(let type):
                return .verticalSpacingBottom(value, type)
            case .horizontalSpacingLeading(let type):
                return .horizontalSpacingLeading(value, type)
            case .horizontalSpacingTrailing(let type):
                return .horizontalSpacingTrailing(value, type)
            }
        }
    }
}

