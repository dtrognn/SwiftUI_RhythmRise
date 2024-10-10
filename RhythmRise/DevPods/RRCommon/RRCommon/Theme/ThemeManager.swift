//
//  ThemeManager.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

public class ThemeManager: ObservableObject {
    public static var shared = ThemeManager()

    @Published public var theme: IRRTheme
    public var layout: IRRLayout = RRLayout()
    public var font: IRRFont = RRFont()

    private let KEY_APP_THEME_TYPE = "KEY_APP_THEME_TYPE"

    public init() {
        let isDarkMode = UserDefaults.standard.bool(forKey: KEY_APP_THEME_TYPE)
        theme = isDarkMode ? AppDarkTheme() : AppLightTheme()
    }

    public var isDarkMode: Bool {
        return theme is AppDarkTheme
    }

    public func switchTheme(_ isDarkMode: Bool) {
        theme = isDarkMode ? AppDarkTheme() : AppLightTheme()
        UserDefaults.standard.set(isDarkMode, forKey: KEY_APP_THEME_TYPE)
    }
}
