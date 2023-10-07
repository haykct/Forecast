//
//  ForecastCoordinator.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 07.10.23.
//

import UIKit

final class ForecastCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let locationService: LocationService

    init(navigationController: UINavigationController, locationService: LocationService) {
        self.navigationController = navigationController
        self.locationService = locationService
    }

    func start() {
        let factory = ForecastViewControllerFactory(locationService: locationService, coordinator: self)
        let forecastViewController = factory.makeViewController() as! ForecastViewController

        navigationController.setViewControllers([forecastViewController], animated: false)
    }
}
