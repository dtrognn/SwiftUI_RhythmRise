//
//  Router.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

public protocol Route: Hashable {}

public enum EmptyRoute: Route {}

public class Router: ObservableObject {
    @Published public var navigationPath: NavigationPath

    public init() {
        self.navigationPath = NavigationPath()
    }

    public func route(to destination: any Route) {
        navigationPath.append(destination)
    }

    public func pop() {
        if navigationPath.isEmpty { return }
        navigationPath.removeLast()
    }

    public func popToRoot() {
        navigationPath.removeLast(depth)
    }

    public var depth: Int {
        return navigationPath.count
    }
}
