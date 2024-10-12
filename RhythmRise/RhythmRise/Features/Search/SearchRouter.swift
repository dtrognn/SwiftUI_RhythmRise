//
//  SearchRouter.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import SwiftUI
import RRCommon

enum SearchRoute: Route {}

struct SearchRouterView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            SearchView()
                .navigationDestination(for: SearchRoute.self) { destination in

                }
        }.environmentObject(router)
    }
}
