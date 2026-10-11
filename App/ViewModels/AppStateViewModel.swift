//
//  AppStateViewModel.swift
//  App
//

import SwiftUI
import Combine

@MainActor
public final class AppStateViewModel: ObservableObject {
    @Published public var isAuthenticated: Bool = false
    @Published public var currentUser: User? = nil
    @Published public var selectedTab: Tab = .home
    @Published public var isDarkMode: Bool? = nil

    public enum Tab: Hashable {
        case home
        case explore
        case profile
        case settings
    }

    private let authService: AuthServiceProtocol

    public init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
        Task {
            await checkAuthStatus()
        }
    }

    public var preferredColorScheme: ColorScheme? {
        guard let isDark = isDarkMode else { return nil }
        return isDark ? .dark : .light
    }

    public func checkAuthStatus() async {
        do {
            if let user = try await authService.currentUser() {
                self.currentUser = user
                self.isAuthenticated = true
            } else {
                self.isAuthenticated = false
            }
        } catch {
            self.isAuthenticated = false
        }
    }

    public func login(email: String, pass: String) async throws {
        let user = try await authService.login(email: email, password: pass)
        self.currentUser = user
        self.isAuthenticated = true
    }

    public func logout() async {
        try? await authService.logout()
        self.currentUser = nil
        self.isAuthenticated = false
    }
}
