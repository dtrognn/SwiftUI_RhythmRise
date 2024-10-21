//
//  LanguageLocal.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import Foundation
import Combine

class LanguageLocal {
    static let shared = LanguageLocal()
    var bundleLanguage: Bundle = Bundle.tfCommonResourceBundle()
    private var cancellableSet: Set<AnyCancellable> = []

    private init() {
        LanguageManager.shared.onChangeLanguageBundle.sink { [weak self] _ in
            self?.loadLanguage()
        }.store(in: &cancellableSet)
    }

    func loadLanguage(languageCode: String? = nil) {
        let languageCodeCurrent = languageCode == nil ? LanguageManager.shared.currentLanguage.getLanguageCode() : languageCode!

        if let path = Bundle.tfCommonResourceBundle().path(forResource: languageCodeCurrent, ofType: "lproj") {
            bundleLanguage = Bundle(path: path)!
        }
    }
}

func language (_ keyLanguage: String) -> String {
    return NSLocalizedString(keyLanguage, bundle: LanguageLocal.shared.bundleLanguage, comment: "")
}
