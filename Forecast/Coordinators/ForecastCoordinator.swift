//
//  ForecastCoordinator.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 07.10.23.
//

import UIKit

final class ForecastCoordinator: Coordinator {
    //MARK: Public properties
    var childCoordinators: [Coordinator] = []
    @Injected var navigationController: UINavigationController

    //MARK: Public methods
    func start() {
        let viewModel = ForecastViewModel(coordinator: self)
        let creator = { ForecastViewController(coder: $0, viewModel: viewModel) }
        let storyboard = UIStoryboard(name: "Forecast", bundle: .main)
        let forecastViewController = storyboard.instantiateViewController(identifier: "forecastVC", creator: creator)

        navigationController.setViewControllers([forecastViewController], animated: false)
    }
}
