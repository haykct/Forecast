//
//  ServiceError.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

enum ServiceError: Error, Equatable {
    case locationError
    case networkError(NetworkError)

    var description: String {
        switch self {
        case .locationError:
            return "Reload the location or search for a different one."
        case .networkError(let error):
            return error.errorDescription
        }
    }
}
