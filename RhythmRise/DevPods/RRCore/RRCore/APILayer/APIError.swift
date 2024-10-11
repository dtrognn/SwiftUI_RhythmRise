//
//  APIError.swift
//  RRCore
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

public enum APIError: LocalizedError {
    case invalidResponse
    case invalidURL
    case invalidToken
    case decodingError
    case unknowned

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server."
        case .invalidURL:
            return "Invalid URL."
        case .invalidToken:
            return "Invalid token"
        case .decodingError:
            return "Failed to decode the response."
        case .unknowned:
            return "Unknown"
        }
    }
}
