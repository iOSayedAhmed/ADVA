//
//  NetworkService.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation
import Network

class NetworkService {
    enum NetworkError: Error {
        case notConnected
        case invalidURL
        case invalidResponse
        case badRequest
        case unauthorized
        case serverError
        case notFound
        case unknownError(statusCode: Int?)
    }

    enum Endpoint {
        case allPhotos
        case allAlbums

        var description: String {
            switch self {
            case .allPhotos: return "photos"
            case .allAlbums: return "albums"
            }
        }
        
        var methodType:String {
            switch self {
            case .allPhotos,.allAlbums : return "GET"
            }
            
        }
    }

    
    private let session: URLSession
    private let config = ConfigurationManager.shared

    init(session: URLSession = .shared) {
        self.session = session
    }

    private func isNetworkConnected() -> Bool {
        let monitor = NWPathMonitor()
        let semaphore = DispatchSemaphore(value: 0)
        var isConnected = false

        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            semaphore.signal()
        }

        let queue = DispatchQueue.global(qos: .userInitiated)
        monitor.start(queue: queue)

        _ = semaphore.wait(timeout: .now() + 5)

            return isConnected
    }

    public func request<T: Codable>(endpoint: Endpoint, parameters: [String: String]) async throws -> T {
        guard isNetworkConnected() else { throw NetworkError.notConnected }

        do {
            var fullURL = try? addParametersToURL(baseURL: config.baseURL, parameters: parameters)
            fullURL = fullURL?.appendingPathComponent(endpoint.description)

            guard let concatenatedURL = fullURL else {
                throw NetworkError.invalidURL
            }

            var request = URLRequest(url: concatenatedURL)
            request.httpMethod = endpoint.methodType
            request.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Accept-Language": config.getCurrentLanguage()
            ]

            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            let dataToDecode = try handleErrors(statusCode: httpResponse.statusCode, data: data)

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: dataToDecode)

            //encode data to display it as pretty json
            let prettyPrintedData = try JSONEncoder().encode(decodedData)
            if let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
                print(prettyPrintedString)
            }
            return decodedData

        } catch {
            print(error.localizedDescription)
            throw NetworkError.unknownError(statusCode: nil)
        }
    }

    func addParametersToURL(baseURL: String, parameters: [String: String]) throws -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        guard let _ = urlComponents else {
            throw NetworkError.invalidURL
        }

        let queryItems: [URLQueryItem] = parameters.map { key, value in
            return URLQueryItem(name: key, value: value)
        }

        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else { return nil }

        return url
    }

    private func handleErrors(statusCode: Int, data: Data) throws -> Data {
        switch statusCode {
        case 200..<300:
            return data
        case 301:
            throw NetworkError.unauthorized
        case 400:
            throw NetworkError.badRequest
        case 404:
            throw NetworkError.notFound
        case 500..<600:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknownError(statusCode: statusCode)
        }
    }
}
