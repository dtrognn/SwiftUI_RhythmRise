//
//  Extension.swift
//  RRCore
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
