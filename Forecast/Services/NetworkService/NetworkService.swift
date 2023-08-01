//
//  NetworkService.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

final class NetworkService {
    enum NetworkError: Error {
        case noConnection
        case serverUnavailable

        var description: String {
            switch self {
            case .noConnection:
                return "No connection"
            case .serverUnavailable:
                return "Server unavailable"
            }
        }
    }
}
