//
//  UtilsHelpers.swift
//  RhythmRise
//
//  Created by dtrognn on 16/10/24.
//

import Combine
import RRCommon
import SwiftUI
import UIImageColors

final class UtilsHelpers {
    init() {}

    static func getDominantColor(from imageUrlString: String) -> AnyPublisher<UIColor?, Never> {
        return fetchDominantColor(from: imageUrlString)
    }

    private static func fetchDominantColor(from imageUrlString: String) -> AnyPublisher<UIColor?, Never> {
        guard let imageUrl = URL(string: imageUrlString) else {
            return Just(nil).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: imageUrl)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, _ -> UIImage? in
                UIImage(data: data)
            }.flatMap { image -> AnyPublisher<UIColor?, Never> in
                Future<UIColor?, Never> { promise in
                    DispatchQueue.global(qos: .background).async {
                        guard let image = image else {
                            promise(.success(nil))
                            return
                        }
                        let colors = image.getColors()
                        promise(.success(colors?.secondary))
                    }
                }.eraseToAnyPublisher()
            }.replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
