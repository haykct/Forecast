//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI
import CoreLocation

struct WeatherTodayContentView: View {
    //MARK: Public properties
    @StateObject var viewModel: WeatherTodayViewModel

    //MARK: Private properties
    @State private var isWeatherTodayViewVisible = false
    
    var body: some View {
        VStack {
            if let error = viewModel.serviceError {
                let _ = print("error")
                ErrorView(viewModel: viewModel, serviceError: error)
            } else {
                WeatherTodayView(viewModel: viewModel)
                    .onAppear {
                        if !isWeatherTodayViewVisible {
                            print("onAppear")
                            isWeatherTodayViewVisible = true
                            viewModel.requestLocationAndNetworkData()
                        }
                    }
            }
        }
    }
}
