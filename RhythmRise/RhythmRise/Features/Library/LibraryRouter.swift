//
//  LibraryRouter.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import RRCommon
import SwiftUI

enum LibraryRoute: Route {
    case showDetail(String)
    case mediaDetail(String, MediaType)
}

struct LibraryRouter: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            LibraryView()
                .navigationDestination(for: LibraryRoute.self) { destination in
                    switch destination {
                    case .showDetail(let id):
                        ShowDetailView(id)
                    case .mediaDetail(let id, let type):
                        MediaDetailView(id: id, playerMediaType: type)
                    }
                }
        }.environmentObject(router)
    }
}
