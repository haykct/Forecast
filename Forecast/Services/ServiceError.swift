//
//  ServiceError.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

enum ServiceError: Error, Equatable {
    case locationError
    case networkError(NetworkError)

    var descriptionKey: String {
        switch self {
        case .locationError:
            return "reload_location"
        case let .networkError(error):
            return error.descriptionKey
        }
    }
}
