//
//  ForecastView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import SwiftUI

struct ForecastView: UIViewControllerRepresentable {
    // MARK: Private properties

    private let coordinator = ForecastCoordinator()

    // MARK: Public methods

    func makeUIViewController(context _: Context) -> UINavigationController {
        coordinator.start()

        return coordinator.navigationController
    }

    func updateUIViewController(_: UINavigationController, context _: Context) {}
}
