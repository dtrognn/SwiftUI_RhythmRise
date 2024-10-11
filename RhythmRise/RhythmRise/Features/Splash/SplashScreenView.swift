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
    @StateObject private var vm: SplashScreenVM = .init()

    var body: some View {
        Text("SplashScreenView")
            .onAppear {
                vm.checkAppState()
            }.onReceive(vm.onNextScreen) { screen in
                appRouter.updateScreen(screen == .mainTab)
                appRouter.subcribeLoginState()
            }
    }
}
