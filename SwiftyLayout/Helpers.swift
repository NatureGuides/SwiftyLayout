//
//  Helpers.swift
//  SwiftyLayout
//
//  Created by Joe Thomson on 26/05/2020.
//  Copyright © 2020 Joe Thomson. All rights reserved.
//

import UIKit

extension UIView
{
    /// Sets `translatesAutoresizingMaskIntoConstraints` on this view to the given value, unless this view does not allow it to be set.
    /// - Note: The only known instance where a view cannot have this set is currently the content view of a `UITableViewCell`.
    func ifSafeSet(translatesAutoresizingMaskIntoConstraints: Bool)
    {
        guard self.superview == nil || self.superview is UITableViewCell == false else { return }
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    }
}
