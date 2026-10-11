//
//  NetworkError.swift
//  App
//

import Foundation

public enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, message: String?)
    case decodingFailed(String)
    case unauthorized
    case serverError
    case noConnection
    case unknown(String)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Некорректный адрес URL."
        case .invalidResponse:
            return "Получен недопустимый ответ от сервера."
        case .httpError(let code, let msg):
            return msg ?? "Ошибка HTTP со статусом \(code)."
        case .decodingFailed(let reason):
            return "Ошибка декодирования данных: \(reason)"
        case .unauthorized:
            return "Сессия истекла. Пожалуйста, выполните вход повторно."
        case .serverError:
            return "Внутренняя ошибка сервера. Повторите попытку позже."
        case .noConnection:
            return "Отсутствует подключение к сети интернет."
        case .unknown(let desc):
            return desc
        }
    }
}
