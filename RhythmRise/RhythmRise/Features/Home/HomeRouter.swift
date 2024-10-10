//
//  HomeRouterView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

enum HomeRoute: Route {}

struct HomeRouterView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            HomeView()
                .navigationDestination(for: HomeRoute.self) { _ in
                }
        }.environmentObject(router)
    }
}
