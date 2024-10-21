//
//  RRCommonConfig.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

public class RRCommonConfig {
    private init() {}

    public static let shared = RRCommonConfig()

    public func loadConfig() {
        LanguageLocal.shared.loadLanguage()
    }
}
