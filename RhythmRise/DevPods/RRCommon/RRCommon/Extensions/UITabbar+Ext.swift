//
//  UITabbar+Ext.swift
//  RRCommon
//
//  Created by dtrognn on 18/10/24.
//

import Foundation

public extension UITabBarController {
    var height: CGFloat {
        return self.tabBar.frame.size.height
    }

    var width: CGFloat {
        return self.tabBar.frame.size.width
    }
}
