//
//  SplashScreenView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var router: Router = .init()

    var body: some View {
        Text("SplashScreenView")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    nextScreen()
                }
            }
    }

    func nextScreen() {
        appRouter.updateScreen(!AppDataManager.shared.isLogout)
        appRouter.subcribeLoginState()
    }
}
