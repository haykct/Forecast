//
//  WeatherTodayContentViewFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct WeatherTodayContentViewFactory: ViewFactory {
    //MARK: Private properties
    private let locationService: LocationService

    //MARK: Initializers
    init(locationService: LocationService) {
        self.locationService = locationService
    }

    //MARK: Public methods
    func makeView() -> some View {
        let networkService = DefaultNetworkService()
        let viewModel = WeatherTodayViewModel(locationService: locationService, networkService: networkService)
        let view = WeatherTodayContentView(viewModel: viewModel)

        return view
    }
}
