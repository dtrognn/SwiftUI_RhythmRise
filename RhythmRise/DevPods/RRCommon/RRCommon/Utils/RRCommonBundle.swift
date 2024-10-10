//
//  RRCommonBundle.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

public struct RRCommonBundle {
    public static let useResourceBundles = false
    public static let bundleName = "RRCommon.bundle"
}

private class GetBundle { }

extension Bundle {

    public class func tfCommonResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard RRCommonBundle.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(forResource: RRCommonBundle.bundleName,
            withExtension: nil) else {
            fatalError("\(RRCommonBundle.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(RRCommonBundle.bundleName)")
        }
        return resourceBundle
    }
}

extension Image {
    static func image(_ name: String) -> Image {
        return Image(name, bundle: Bundle.tfCommonResourceBundle())
    }
}
