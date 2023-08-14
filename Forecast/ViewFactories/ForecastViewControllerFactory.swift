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

    //MARK: Initializers
    init(locationService: LocationService) {
        self.locationService = locationService
    }

    func makeViewController() -> UIViewController {
        let viewModel = ForecastViewModel(locationService: locationService, networkService: DefaultNetworkService())
        let creator = { ForecastViewController(coder: $0, viewModel: viewModel) }
        let storyboard = UIStoryboard(name: "Forecast", bundle: .main)
        let forecastViewController = storyboard.instantiateViewController(identifier: "forecastVC", creator: creator)

        return forecastViewController
    }
}
