//
//  Tab.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

enum Tab: CaseIterable {
    case home
    case search
    case library

    var image: String {
        return switch self {
        case .home: "ic_tabbar_home"
        case .search: "ic_tabbar_search"
        case .library: "ic_tabbar_library"
        }
    }

    var title: String {
        return switch self {
        case .home: "Tabbar_A_01"
        case .search: "Tabbar_A_02"
        case .library: "Tabbar_A_03"
        }
    }
}

struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}
