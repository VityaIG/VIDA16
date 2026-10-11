//
//  User.swift
//  App
//

import Foundation

public struct User: Identifiable, Codable, Equatable {
    public let id: String
    public let email: String
    public let fullName: String
    public let avatarURL: URL?
    public let createdAt: Date

    public init(
        id: String = UUID().uuidString,
        email: String,
        fullName: String,
        avatarURL: URL? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.avatarURL = avatarURL
        self.createdAt = createdAt
    }

    public static let mock = User(
        id: "usr_01",
        email: "alex.developer@example.com",
        fullName: "Алексей Иванов",
        avatarURL: URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=256&q=80"),
        createdAt: Date()
    )
}
