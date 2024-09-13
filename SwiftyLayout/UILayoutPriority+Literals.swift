//
//  UILayoutPriority+Literals.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

extension UILayoutPriority: @retroactive ExpressibleByIntegerLiteral
{
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int)
    {
        self.init(rawValue: Float(value))
    }
}
