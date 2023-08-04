//
//  ForecastView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import SwiftUI

struct ForecastView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let factory = ForecastViewControllerFactory()
        let forecastViewController = factory.makeViewController() as! ForecastViewController
        let navController = UINavigationController(rootViewController: forecastViewController)

        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {

    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
