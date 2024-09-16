//
//  AutolayoutTarget.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

/// A protocol to allow us to mix and match between UIViews and UILayoutGuides.
@MainActor public protocol AutolayoutTarget: AnyObject
{
    var underlyingView: UIView? { get }
    var superview: UIView? { get }
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension UIView: AutolayoutTarget
{
    public var underlyingView: UIView?
    {
        return self
    }
}

extension UILayoutGuide: AutolayoutTarget
{
    public var underlyingView: UIView?
    {
        self.owningView
    }
    
    public var superview: UIView?
    {
        self.owningView?.superview
    }
}
