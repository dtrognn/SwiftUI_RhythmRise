//
//  Date+Ext.swift
//  RRCommon
//
//  Created by dtrognn on 12/10/24.
//

import Foundation

public extension Date {
    func timeIntervalSince1970() -> Int {
        return Int(self.timeIntervalSince1970)
    }
}
