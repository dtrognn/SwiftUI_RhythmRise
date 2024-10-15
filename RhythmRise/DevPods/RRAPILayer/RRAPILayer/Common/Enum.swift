//
//  Enum.swift
//  RRAPILayer
//
//  Created by dtrognn on 15/10/24.
//

import Foundation

public enum Market: String {
    case vn = "VN"
}

public enum LocaleRequest: String {
    case vn = "vi_VN"
}

public enum IncludeGroups: String, CaseIterable {
    case album
    case single
    case appearsOn = "appears_on"
    case compilation
}
