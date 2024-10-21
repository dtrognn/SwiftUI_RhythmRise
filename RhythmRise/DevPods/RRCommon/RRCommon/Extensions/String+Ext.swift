//
//  String+Ext.swift
//  RRCommon
//
//  Created by dtrognn on 20/10/24.
//

import SwiftUI

public extension String {
    func formatTime(_ type: DateFormatType) -> Self {
        let locale = Locale.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue

        guard let date = dateFormatter.date(from: self) else {
            return self
        }

        let currentYear = Calendar.current.component(.year, from: Date())
        let dateYear = Calendar.current.component(.year, from: date)

        let outputFormatter = DateFormatter()
        outputFormatter.locale = locale

        if dateYear != currentYear {
            if locale.identifier == "vi_VN" {
                outputFormatter.dateFormat = "dd 'thg' MM, yyyy"
            } else {
                outputFormatter.dateFormat = "dd MMM yyyy"
            }
        } else {
            if locale.identifier == "vi_VN" {
                outputFormatter.dateFormat = "dd 'thg' MM"
            } else {
                outputFormatter.dateFormat = "dd MMM"
            }
        }

        return outputFormatter.string(from: date)
    }
}
