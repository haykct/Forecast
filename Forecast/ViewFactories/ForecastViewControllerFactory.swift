//
//  ForecastViewControllerFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import UIKit

struct ForecastViewControllerFactory: ViewControllerFactory {
    func makeViewController() -> UIViewController {
        let viewModel = ForecastViewModel(locationService: DefaultLocationService(), networkService: DefaultNetworkService())
        let creator = { ForecastViewController(coder: $0, viewModel: viewModel) }
        let storyboard = UIStoryboard(name: "Forecast", bundle: .main)
        let forecastViewController = storyboard.instantiateViewController(identifier: "forecastVC", creator: creator)

        return forecastViewController
    }
}
