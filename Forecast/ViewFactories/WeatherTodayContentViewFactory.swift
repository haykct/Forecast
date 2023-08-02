//
//  WeatherTodayContentViewFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct WeatherTodayContentViewFactory: ViewFactory {
    func makeView() -> some View {
        let locationService = DefaultLocationService()
        let networkService = DefaultNetworkService()
        let viewModel = WeatherTodayViewModel(locationService: locationService, networkService: networkService)
        let view = WeatherTodayContentView().environmentObject(viewModel)

        return view
    }
}
