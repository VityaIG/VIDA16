//
//  APIClient.swift
//  App
//

import Foundation

public protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    func requestRaw(_ endpoint: Endpoint) async throws -> Data
}

public final class APIClient: APIClientProtocol {
    public static let shared = APIClient()

    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder

    public init(
        session: URLSession = .shared,
        baseURL: URL = AppConfig.shared.environment.baseURL,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.baseURL = baseURL
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601
    }

    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await requestRaw(endpoint)
        do {
            return try decoder.decode(T.self, data: data)
        } catch let decodingError as DecodingError {
            AppLogger.network.error("Decoding error: \(decodingError.localizedDescription)")
            throw NetworkError.decodingFailed(decodingError.localizedDescription)
        } catch {
            throw NetworkError.decodingFailed(error.localizedDescription)
        }
    }

    public func requestRaw(_ endpoint: Endpoint) async throws -> Data {
        let request = try endpoint.makeURLRequest(baseURL: baseURL)
        AppLogger.network.debug("Request [\(request.httpMethod ?? "GET")] \(request.url?.absoluteString ?? "")")

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            AppLogger.network.debug("Response [\(httpResponse.statusCode)] from \(request.url?.absoluteString ?? "")")

            switch httpResponse.statusCode {
            case 200...299:
                return data
            case 401:
                throw NetworkError.unauthorized
            case 500...599:
                throw NetworkError.serverError
            default:
                let msg = String(data: data, encoding: .utf8)
                throw NetworkError.httpError(statusCode: httpResponse.statusCode, message: msg)
            }
        } catch let urlError as URLError {
            if urlError.code == .notConnectedToInternet {
                throw NetworkError.noConnection
            }
            throw NetworkError.unknown(urlError.localizedDescription)
        } catch let netError as NetworkError {
            throw netError
        } catch {
            throw NetworkError.unknown(error.localizedDescription)
        }
    }
}
