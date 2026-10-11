//
//  AppLogger.swift
//  App
//

import Foundation
import os.log

public enum AppLogger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.example.app"

    public static let general = Logger(subsystem: subsystem, category: "General")
    public static let network = Logger(subsystem: subsystem, category: "Network")
    public static let auth = Logger(subsystem: subsystem, category: "Auth")
    public static let ui = Logger(subsystem: subsystem, category: "UI")
}
