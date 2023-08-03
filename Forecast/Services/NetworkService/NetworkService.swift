//
//  NetworkService.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import Foundation
import Alamofire
import Combine
import XMLCoder

enum NetworkError: Error, Equatable {
    case noConnection
    case dataNotAvailable
    case unableToDecode

    var errorDescription: String {
        switch self {
        case .noConnection:
            return "No internet connection. Please check your internet connection and try again."
        case .dataNotAvailable:
            return "Something unexpected happened. Please try again later."
        case .unableToDecode:
            return "The data received is in an unexpected format. Please contact support for assistance."
        }
    }
}

protocol NetworkService {
    func request<Response>(_ request: Request) -> AnyPublisher<Response, NetworkError> where Response: Decodable
}

final class DefaultNetworkService: NetworkService {
    //MARK: Private properties
    private let session: Session

    //MARK: Initializers
    init(session: Session = AF) {
        self.session = session
    }

    //MARK: Public methods
    func request<Response>(_ request: Request) -> AnyPublisher<Response, NetworkError> where Response : Decodable {
        session
            .request(request.url, parameters: request.parameters)
            .validate()
            .publishData()
            .value()
            .mapError { error in
                if let urlError = error.underlyingError as? URLError,
                    urlError.code == .notConnectedToInternet {
                    return NetworkError.noConnection
                }

                return .dataNotAvailable
            }
            .decode(type: Response.self, decoder: XMLDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError { return networkError }

                return .unableToDecode
            }
            .eraseToAnyPublisher()
    }
}
