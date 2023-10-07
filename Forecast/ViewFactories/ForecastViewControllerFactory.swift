//
//  ForecastViewControllerFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import UIKit

struct ForecastViewControllerFactory: ViewControllerFactory {
    //MARK: Private properties
    private let locationService: LocationService
    private weak var coordinator: ForecastCoordinator?

    //MARK: Initializers
    init(locationService: LocationService, coordinator: ForecastCoordinator) {
        self.locationService = locationService
        self.coordinator = coordinator
    }

    func makeViewController() -> UIViewController {
        let viewModel = ForecastViewModel(locationService: locationService, networkService: DefaultNetworkService(), coordinator: coordinator)
        let creator = { ForecastViewController(coder: $0, viewModel: viewModel) }
        let storyboard = UIStoryboard(name: "Forecast", bundle: .main)
        let forecastViewController = storyboard.instantiateViewController(identifier: "forecastVC", creator: creator)

        return forecastViewController
    }
}
