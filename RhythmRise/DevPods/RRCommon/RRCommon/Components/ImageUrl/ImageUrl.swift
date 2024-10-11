//
//  ImageUrl.swift
//  RRCommon
//
//  Created by dtrognn on 11/10/24.
//

import Kingfisher
import SwiftUI

public enum ImageContentMode {
    case fit
    case fill
}

public struct ImageConfiguration {
    public var urlString: String
    public var url: URL?

    public init(urlString: String, url: URL? = nil) {
        self.urlString = urlString
        self.url = url
    }
}

public struct ImageUrl<Content: View>: View {
    private var configuration: ImageConfiguration
    private var contentMode: ImageContentMode
    private var placeholder: () -> Content
    private var onLoadError: (() -> Void)?

    public init(configuration: ImageConfiguration,
                contentMode: ImageContentMode = .fit,
                onLoadError: (() -> Void)? = nil,
                placeholder: @escaping () -> Content)
    {
        self.configuration = configuration
        self.contentMode = contentMode
        self.placeholder = placeholder
        self.onLoadError = onLoadError
    }

    public var body: some View {
        KFImage.url(configuration.url == nil ? URL(string: configuration.urlString) : configuration.url!)
            .placeholder(placeholder)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onSuccess { _ in }
            .onFailure { _ in
                self.onLoadError?()
            }.resizable()
            .aspectRatio(contentMode: contentMode == .fit ? .fit : .fill)
    }
}
