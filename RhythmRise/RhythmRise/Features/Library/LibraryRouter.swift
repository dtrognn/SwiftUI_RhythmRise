//
//  LibraryRouter.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import RRCommon
import SwiftUI

enum LibraryRoute: Route {}

struct LibraryRouter: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            LibraryView()
                .navigationDestination(for: LibraryRoute.self) { destination in

                }
        }.environmentObject(router)
    }
}
