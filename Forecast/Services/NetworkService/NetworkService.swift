//
//  NetworkService.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import Alamofire
import Combine
import Foundation
import XMLCoder

enum NetworkError: Error, Equatable {
    case noConnection
    case dataNotAvailable
    case unableToDecode

    var descriptionKey: String {
        switch self {
        case .noConnection:
            return "no_internet"
        case .dataNotAvailable:
            return "try_later"
        case .unableToDecode:
            return "unexpected_format"
        }
    }
}

protocol NetworkService {
    func request<Response>(_ request: Request) -> AnyPublisher<Response, NetworkError> where Response: Decodable
}

final class DefaultNetworkService: NetworkService {
    // MARK: Private properties

    private let session: Session

    // MARK: Initializers

    init(session: Session = AF) {
        self.session = session
    }

    // MARK: Public methods

    func request<Response>(_ request: Request) -> AnyPublisher<Response, NetworkError> where Response: Decodable {
        session
            .request(request.url, parameters: request.parameters)
            .validate(statusCode: 200 ... 399)
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
