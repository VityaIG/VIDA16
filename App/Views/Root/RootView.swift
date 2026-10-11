//
//  RootView.swift
//  App
//

import SwiftUI

public struct RootView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @State private var email: String = ""
    @State private var pass: String = ""
    @State private var isSigningIn: Bool = false
    @State private var authError: String? = nil

    public var body: some View {
        Group {
            if appState.isAuthenticated {
                MainTabView()
            } else {
                loginView
            }
        }
        .animation(.easeInOut(duration: 0.25), value: appState.isAuthenticated)
    }

    private var loginView: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Spacer()

                VStack(spacing: 12) {
                    Image(systemName: "swift")
                        .font(.system(size: 64))
                        .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))

                    Text("iOS Starter App")
                        .font(.system(size: 28, weight: .bold))

                    Text("Современная чистая архитектура SwiftUI + MVVM")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 14) {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    SecureField("Пароль", text: $pass)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    if let authError = authError {
                        Text(authError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    PrimaryButton(title: "Войти в систему", icon: "arrow.right.circle.fill", isLoading: isSigningIn) {
                        handleLogin()
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                Button("Пропустить и войти гостем") {
                    withAnimation {
                        appState.isAuthenticated = true
                    }
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            }
        }
    }

    private func handleLogin() {
        authError = nil
        isSigningIn = true
        Task {
            do {
                try await appState.login(email: email.isEmpty ? "demo@example.com" : email, pass: pass.isEmpty ? "password123" : pass)
                isSigningIn = false
            } catch {
                isSigningIn = false
                authError = error.localizedDescription
            }
        }
    }
}
