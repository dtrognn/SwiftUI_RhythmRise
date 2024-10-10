//
//  AppConfigurationManager.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Combine
import Foundation
import RRCommon

final class AppConfigurationManager {
    static let shared = AppConfigurationManager()

    private var cancellableSet: Set<AnyCancellable> = []

    private init() {}

    func loadCommonConfig() {
        RRCommonConfig.shared.loadConfig()
        AppDataManager.shared.appLanguage.loadLanguage()

        configLoading()
        configureAlertMessage()
    }

    private func configLoading() {
        let defaultConfig = DefaultLoadingConfiguration()
        defaultConfig.configure()
        LoadingConfiguration.shared.addLoadingConfiguration(loadingType: .defaultLoading, loading: defaultConfig)
    }

    private func configureAlertMessage() {
        let defaultConfiguration = DefaultAlertMessageConfiguration()
        defaultConfiguration.configure()

        AlertMessageConfiguration.shared.addAlertMessage(.defaultAlert, alertMessage: defaultConfiguration)

        let bannerConfig = BannerAlertMessageConfiguration()
        bannerConfig.configure()
        AlertMessageConfiguration.shared.addAlertMessage(.banner, alertMessage: bannerConfig)
    }
}
