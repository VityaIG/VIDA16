//
//  ProfileView.swift
//  App
//

import SwiftUI

public struct ProfileView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @StateObject private var viewModel = ProfileViewModel()

    public var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .foregroundColor(.accentColor)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.user?.fullName ?? "Пользователь")
                                .font(.headline)
                            Text(viewModel.user?.email ?? "user@example.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section("Редактирование профиля") {
                    HStack {
                        Text("Имя")
                            .foregroundColor(.secondary)
                        TextField("Имя пользователя", text: $viewModel.editedName)
                            .multilineTextAlignment(.trailing)
                    }

                    Button("Сохранить изменения") {
                        viewModel.saveProfile()
                    }
                    .font(.body.weight(.medium))
                    .foregroundColor(.accentColor)
                }

                Section("Информация о сессии") {
                    HStack {
                        Text("Статус")
                        Spacer()
                        Text("Авторизован")
                            .foregroundColor(.green)
                    }
                    HStack {
                        Text("Дата регистрации")
                        Spacer()
                        Text(viewModel.user?.createdAt.formatted(date: .abbreviated, time: .omitted) ?? "Сегодня")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Профиль")
        }
    }
}
