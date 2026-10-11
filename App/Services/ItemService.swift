//
//  ItemService.swift
//  App
//

import Foundation

public protocol ItemServiceProtocol {
    func fetchItems() async throws -> [Item]
    func toggleFavorite(id: String) async throws -> Item
}

public final class ItemService: ItemServiceProtocol {
    public static let shared = ItemService()
    private var cachedItems: [Item] = Item.sampleItems

    private init() {}

    public func fetchItems() async throws -> [Item] {
        // Симуляция сетевой задержки
        try await Task.sleep(nanoseconds: 500_000_000)
        return cachedItems
    }

    public func toggleFavorite(id: String) async throws -> Item {
        guard let index = cachedItems.firstIndex(where: { $0.id == id }) else {
            throw NetworkError.unknown("Элемент не найден")
        }

        let current = cachedItems[index]
        let updated = Item(
            id: current.id,
            title: current.title,
            subtitle: current.subtitle,
            category: current.category,
            timestamp: current.timestamp,
            isFavorite: !current.isFavorite
        )
        cachedItems[index] = updated
        return updated
    }
}
