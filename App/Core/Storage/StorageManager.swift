//
//  StorageManager.swift
//  App
//

import Foundation

public final class StorageManager {
    public static let shared = StorageManager()
    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public enum Key: String {
        case hasCompletedOnboarding
        case appTheme
        case lastSyncTimestamp
    }

    public func set<T>(_ value: T?, forKey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }

    public func string(forKey key: Key) -> String? {
        defaults.string(forKey: key.rawValue)
    }

    public func bool(forKey key: Key) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }

    public func double(forKey key: Key) -> Double {
        defaults.double(forKey: key.rawValue)
    }

    public func remove(forKey key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
