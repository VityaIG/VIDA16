//
//  HomeViewModel.swift
//  App
//

import SwiftUI
import Combine

@MainActor
public final class HomeViewModel: ObservableObject {
    @Published public var items: [Item] = []
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var searchText: String = ""

    private let itemService: ItemServiceProtocol

    public init(itemService: ItemServiceProtocol = ItemService.shared) {
        self.itemService = itemService
    }

    public var filteredItems: [Item] {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return items
        }
        return items.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.subtitle.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }

    public func loadData() async {
        isLoading = true
        errorMessage = nil
        do {
            self.items = try await itemService.fetchItems()
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }

    public func toggleFavorite(item: Item) async {
        do {
            let updated = try await itemService.toggleFavorite(id: item.id)
            if let index = items.firstIndex(where: { $0.id == updated.id }) {
                items[index] = updated
            }
        } catch {
            self.errorMessage = "Не удалось обновить статус."
        }
    }
}
