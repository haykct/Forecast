//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

struct WeatherTodayContentView: View {
    //MARK: Private properties
    @State private var isContentViewAppeared = false
    @State private var isWeatherTodayViewVisible = false
    @EnvironmentObject private var viewModel: WeatherTodayViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch viewModel.authorizationStatus {
            case .loading:
                ProgressView()
            case .authorized:
                if let error = viewModel.serviceError {
                    AppStateView<WeatherTodayViewModel>(state: .serviceError(error))
                        .visibleTabBar()
                } else {
                    WeatherTodayView()
                        .visibleTabBar()
                        .onAppear {
                            if !isWeatherTodayViewVisible {
                                isWeatherTodayViewVisible = true
                                viewModel.requestLocationAndNetworkData()
                            }
                        }
                }
            default:
                AppStateView<WeatherTodayViewModel>(state: .location)
                    .hiddenTabBar()
            }
        }
        .onAppear {
            if !isContentViewAppeared {
                isContentViewAppeared = true
                viewModel.subscribeForAuthorizationStatusUpdate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTodayContentView()
            .environmentObject(WeatherTodayViewModel(locationService: DefaultLocationService(),
                                                     networkService: DefaultNetworkService()))
    }
}
