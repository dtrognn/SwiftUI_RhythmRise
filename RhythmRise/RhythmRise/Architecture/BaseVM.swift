//
//  BaseVM.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Combine
import Foundation
import RRCommon

open class BaseViewModel: ObservableObject {
    var cancellableSet: Set<AnyCancellable> = []

    init() {
        initData()
        makeSubscription()
    }

    open func initData() {

    }

    open func makeSubscription() {
        
    }

    open func showLoading(_ isLoading: Bool) {
        LoadingConfiguration.shared.showLoading(isLoading)
    }

    func showErrorMessage(_ errorMessage: String) {
        AlertMessageConfiguration.shared.showMessage(errorMessage, alertMessageType: .banner)
    }

    func showSuccessMessage(_ message: String) {
        AlertMessageConfiguration.shared.showMessage(message, alertMessageType: .banner, style: .success)
    }
}
