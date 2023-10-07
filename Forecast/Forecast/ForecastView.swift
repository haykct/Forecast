//
//  ForecastView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import SwiftUI

struct ForecastView: UIViewControllerRepresentable {
    //MARK: Private properties
    private let coordinator: ForecastCoordinator

    //MARK: Initializers
    init(locationService: LocationService) {
        self.coordinator = ForecastCoordinator(navigationController: UINavigationController(), locationService: locationService)
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        coordinator.start()

        return coordinator.navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
