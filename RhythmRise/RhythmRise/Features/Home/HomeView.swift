//
//  HomeView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    var sc: ScreenConfiguration {
        return .init(title: "", showNaviBar: false)
    }

    var body: some View {
        Text("Home")
    }
}
