//
//  Injection.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 24.10.23.
//

import CoreLocation
import Swinject
import UIKit

class Injection {
    // MARK: Public properties

    static let shared = Injection()

    lazy var container = Container { container in
        register(using: container)
    }

    // MARK: Initializers

    private init() {}
}

extension Injection {
    private func register(using container: Container) {
        container.register(NetworkService.self) { _ in
            DefaultNetworkService()
        }
        .inObjectScope(.container)

        container.register(LocationService.self) { _ in
            DefaultLocationService(locationManager: CLLocationManager())
        }

        container.register(UINavigationController.self) { _ in
            UINavigationController()
        }
    }
}
