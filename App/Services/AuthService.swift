//
//  AuthService.swift
//  App
//

import Foundation

public protocol AuthServiceProtocol {
    func currentUser() async throws -> User?
    func login(email: String, password: String) async throws -> User
    func logout() async throws
}

public final class AuthService: AuthServiceProtocol {
    public static let shared = AuthService()
    private let keychain = KeychainManager.shared
    private let tokenKey = "auth_session_token"

    private init() {}

    public func currentUser() async throws -> User? {
        guard keychain.get(key: tokenKey) != nil else {
            return nil
        }
        return User.mock
    }

    public func login(email: String, password: String) async throws -> User {
        // Симуляция сетевого запроса авторизации
        try await Task.sleep(nanoseconds: 600_000_000)

        guard !email.isEmpty, password.count >= 6 else {
            throw NetworkError.httpError(statusCode: 400, message: "Некорректный email или пароль менее 6 символов.")
        }

        keychain.save(key: tokenKey, value: "mock_jwt_token_\(UUID().uuidString)")
        return User(email: email, fullName: "Пользователь")
    }

    public func logout() async throws {
        keychain.delete(key: tokenKey)
    }
}
