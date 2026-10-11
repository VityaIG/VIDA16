//
//  AppConfig.swift
//  App
//

import Foundation

public struct AppConfig {
    public static let shared = AppConfig()

    #if DEBUG
    public let environment: AppEnvironment = .development
    #else
    public let environment: AppEnvironment = .production
    #endif

    public let appName: String = "App"
    public let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    public let buildNumber: String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    public let supportEmail: String = "support@example.com"

    private init() {}
}
