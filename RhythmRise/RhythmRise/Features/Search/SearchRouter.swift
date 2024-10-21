//
//  SearchRouter.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

enum SearchRoute: Route {
    case categorysPlaylists(String)
}

struct SearchRouterView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            SearchView()
                .navigationDestination(for: SearchRoute.self) { destination in
                    switch destination {
                    case .categorysPlaylists(let categoryId):
                        CategorysPlaylistsView(categoryId)
                    }
                }
        }.environmentObject(router)
    }
}
