//
//  Environment.swift
//  App
//

import Foundation

public enum AppEnvironment: String, CaseIterable {
    case development
    case staging
    case production

    public var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "https://api-dev.example.com/v1")!
        case .staging:
            return URL(string: "https://api-staging.example.com/v1")!
        case .production:
            return URL(string: "https://api.example.com/v1")!
        }
    }

    public var allowsLogging: Bool {
        switch self {
        case .development, .staging:
            return true
        case .production:
            return false
        }
    }
}
