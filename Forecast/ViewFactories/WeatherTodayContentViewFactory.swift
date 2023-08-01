//
//  WeatherTodayContentViewFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct WeatherTodayContentViewFactory: ViewFactory {
    func makeView() -> some View {
        let service = DefaultLocationService()
        let viewModel = WeatherTodayViewModel(locationService: service)
        let view = WeatherTodayContentView().environmentObject(viewModel)

        return view
    }
}
