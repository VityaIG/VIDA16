//
//  Item.swift
//  App
//

import Foundation

public struct Item: Identifiable, Codable, Equatable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let category: String
    public let timestamp: Date
    public let isFavorite: Bool

    public init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String,
        category: String,
        timestamp: Date = Date(),
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.timestamp = timestamp
        self.isFavorite = isFavorite
    }

    public static let sampleItems: [Item] = [
        Item(title: "Модульная архитектура", subtitle: "Разделение на Core, Services, Models и UI слои", category: "Architecture", isFavorite: true),
        Item(title: "Сетевой слой async/await", subtitle: "URLSession клиент с обработкой ошибок и декодированием", category: "Networking"),
        Item(title: "SwiftUI & State Flow", subtitle: "Observable ViewModel с чистым жизненным циклом", category: "UI", isFavorite: true),
        Item(title: "Безопасное хранение", subtitle: "Keychain интеграция для хранения токенов авторизации", category: "Security")
    ]
}
