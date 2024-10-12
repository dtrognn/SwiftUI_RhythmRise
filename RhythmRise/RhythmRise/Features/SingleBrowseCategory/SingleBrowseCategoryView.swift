//
//  SingleBrowseCategoryView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct SingleBrowseCategoryView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm: SingleBrowseCategoryVM

    init(_ browseCategory: BrowseCategoryItemViewData) {
        self._vm = StateObject(wrappedValue: SingleBrowseCategoryVM(browseCategory))
    }

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", showBackButton: true, hidesBottomBarWhenPushed: true, showNaviBar: true)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {

                }
            }
        }.onAppear() {
            vm.loadData()
        }
    }
}
