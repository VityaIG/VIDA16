//
//  HomeView.swift
//  App
//

import SwiftUI

public struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    public var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.items.isEmpty {
                    ProgressView("Загрузка данных...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage, viewModel.items.isEmpty {
                    StateCardView(
                        icon: "exclamationmark.triangle",
                        title: "Ошибка загрузки",
                        message: error,
                        buttonTitle: "Повторить"
                    ) {
                        Task { await viewModel.loadData() }
                    }
                } else if viewModel.filteredItems.isEmpty {
                    StateCardView(
                        icon: "magnifyingglass",
                        title: "Ничего не найдено",
                        message: "Попробуйте изменить поисковый запрос"
                    )
                } else {
                    List {
                        Section {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Xcode iOS Template")
                                    .font(.headline)
                                Text("Проект подготовлен для работы с Xcode 15/16, Swift 5.9+, Swift 6, Git и CI/CD.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }

                        Section("Компоненты архитектуры") {
                            ForEach(viewModel.filteredItems) { item in
                                itemRow(for: item)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .refreshable {
                        await viewModel.loadData()
                    }
                }
            }
            .navigationTitle("Главная")
            .searchable(text: $viewModel.searchText, prompt: "Поиск по модулям")
            .task {
                if viewModel.items.isEmpty {
                    await viewModel.loadData()
                }
            }
        }
    }

    private func itemRow(for item: Item) -> some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(item.title)
                        .font(.body.weight(.medium))
                    Text(item.category)
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.accentColor.opacity(0.12))
                        .foregroundColor(.accentColor)
                        .clipShape(Capsule())
                }

                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button {
                Task {
                    await viewModel.toggleFavorite(item: item)
                }
            } label: {
                Image(systemName: item.isFavorite ? "star.fill" : "star")
                    .foregroundColor(item.isFavorite ? .yellow : .secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}
