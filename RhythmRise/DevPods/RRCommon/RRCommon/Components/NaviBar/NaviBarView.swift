//
//  NaviBarView.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

import SwiftUI

struct NaviBarView: View {
    @ObservedObject private var screenConfiguration: ScreenConfiguration
    @EnvironmentObject private var router: Router

    init(_ screenConfiguration: ScreenConfiguration) {
        self.screenConfiguration = screenConfiguration
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if screenConfiguration.showBackButton {
                    backButton
                }
                Spacer()
                Text(screenConfiguration.title)
                    .font(.headline)
                Spacer()
                backButton.opacity(0)
            }.padding(16)
                .navigationBarHidden(true)
                .background(
                    Color.clear
                        .ignoresSafeArea(edges: .top)
                )
            if screenConfiguration.showNaviUnderline {
                StraightLineView()
            }
        }
    }
}

private extension NaviBarView {
    private var backButton: some View {
        return Button {
            if screenConfiguration.onBackAction != nil {
                screenConfiguration.onBackAction?()
            } else {
                router.pop()
            }
        } label: {
            Image.image("ic_arrow_back")
                .resizable()
                .frame(width: 22, height: 22)
        }
    }

    var titleSection: some View {
        return VStack {
            Text(LocalizedStringKey(screenConfiguration.title))
                .lineLimit(1)
        }
    }
}
