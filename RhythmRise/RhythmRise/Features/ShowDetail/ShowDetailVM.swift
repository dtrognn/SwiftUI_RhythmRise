//
//  ShowDetailVM.swift
//  RhythmRise
//
//  Created by dtrognn on 19/10/24.
//

import Foundation
import RRAPILayer

final class ShowDetailVM: BaseViewModel {
    @Published var show: MediaItemViewData?
    private var id: String

    init(_ id: String) {
        self.id = id
    }

    func loadData() {
        apiGetShow()
    }
}

// MARK: - API

extension ShowDetailVM {
    // TODO: - get show
    private func apiGetShow() {
        let params = GetShowEndpoint.Request()
        GetShowEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

//                guard let
                let showMapping = MediaFactory.mapping(type: .show, data: response)
                self.show = MediaItemViewData(showMapping)
            }.store(in: &cancellableSet)
    }
}
