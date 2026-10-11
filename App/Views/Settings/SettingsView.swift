//
//  SettingsView.swift
//  App
//

import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @AppStorage("notifications_enabled") private var notificationsEnabled: Bool = true
    @AppStorage("biometrics_enabled") private var biometricsEnabled: Bool = false

    public var body: some View {
        NavigationStack {
            List {
                Section("Внешний вид") {
                    Picker("Тема оформления", selection: Binding(
                        get: {
                            if let isDark = appState.isDarkMode {
                                return isDark ? 2 : 1
                            }
                            return 0
                        },
                        set: { (val: Int) in
                            switch val {
                            case 1: appState.isDarkMode = false
                            case 2: appState.isDarkMode = true
                            default: appState.isDarkMode = nil
                            }
                        }
                    )) {
                        Text("Системная").tag(0)
                        Text("Светлая").tag(1)
                        Text("Тёмная").tag(2)
                    }
                }

                Section("Безопасность и уведомления") {
                    Toggle("Push-уведомления", isOn: $notificationsEnabled)
                    Toggle("Face ID / Touch ID", isOn: $biometricsEnabled)
                }

                Section("О приложении") {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text("\(AppConfig.shared.appVersion) (\(AppConfig.shared.buildNumber))")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Окружение")
                        Spacer()
                        Text(AppConfig.shared.environment.rawValue.capitalized)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Поддержка")
                        Spacer()
                        Text(AppConfig.shared.supportEmail)
                            .foregroundColor(.accentColor)
                    }
                }

                Section {
                    Button(role: .destructive) {
                        Task {
                            await appState.logout()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Выйти из аккаунта")
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Настройки")
        }
    }
}
