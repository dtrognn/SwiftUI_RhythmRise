//
//  HomeRouterView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

enum HomeRoute: Route {
    case artistDetail(String, PlayerMediaType)
}

struct HomeRouterView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            HomeView()
                .navigationDestination(for: HomeRoute.self) { destination in
                    switch destination {
                    case .artistDetail(let id, let type):
                        ArtistDetailView(id: id, playerMediaType: type)
                    }
                }
        }.environmentObject(router)
    }
}
