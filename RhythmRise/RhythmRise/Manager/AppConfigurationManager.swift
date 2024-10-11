//
//  AppConfigurationManager.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Combine
import Foundation
import RRCommon
import RRCore

final class AppConfigurationManager {
    static let shared = AppConfigurationManager()

    private var cancellableSet: Set<AnyCancellable> = []

    private init() {}

    func loadCommonConfig() {
        RRCommonConfig.shared.loadConfig()
        loadModulesConfig()
        AppDataManager.shared.appLanguage.loadLanguage()

        configLoading()
        configureAlertMessage()
    }

    private func loadModulesConfig() {
        APIConfig.shared.configure(
            baseUrl: URLEnvironment(
                baseUrl: AppDefineConfiguration.baseUrl,
                baseAuthorizeUrl: AppDefineConfiguration.baseAuthorizeUrl,
                clientId: AppDefineConfiguration.clientID,
                clientSecretId: AppDefineConfiguration.clientSecretID,
                redirectUri: AppDefineConfiguration.redirectURIs))
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
