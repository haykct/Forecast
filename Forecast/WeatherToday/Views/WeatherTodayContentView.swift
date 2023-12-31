//
//  WeatherTodayContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import CoreLocation
import SwiftUI

struct WeatherTodayContentView: View {
    // MARK: Public properties

    @StateObject var viewModel: WeatherTodayViewModel

    // MARK: Private properties

    @State private var isWeatherTodayViewVisible = false

    var body: some View {
        VStack {
            if let error = viewModel.serviceError {
                ErrorView(viewModel: viewModel, serviceError: error)
            } else {
                WeatherTodayView(viewModel: viewModel)
                    .onAppear {
                        if !isWeatherTodayViewVisible {
                            isWeatherTodayViewVisible = true
                            viewModel.requestLocationAndNetworkData()
                        }
                    }
            }
        }
    }
}
