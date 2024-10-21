//
//  AppLanguage.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Combine
import SwiftUI
import RRCommon

class AppLanguage {
    var bundleLanguage: Bundle = .main
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        LanguageManager.shared.onChangeLanguageBundle.sink { [weak self] _ in
            self?.loadLanguage()
        }.store(in: &cancellableSet)
    }

    func loadLanguage(languageCode: String? = nil) {
        let languageCodeCurrent = languageCode == nil ? LanguageManager.shared.currentLanguage.getLanguageCode() : languageCode!

        if let path = Bundle.main.path(forResource: languageCodeCurrent, ofType: "lproj") {
            bundleLanguage = Bundle(path: path)!
        }
    }
}

func language(_ keyLanguage: String) -> String {
    return NSLocalizedString(keyLanguage, bundle: AppDataManager.shared.appLanguage.bundleLanguage, comment: "")
}

func language(_ keyLanguage: String) -> LocalizedStringKey {
    return LocalizedStringKey(keyLanguage)
}
