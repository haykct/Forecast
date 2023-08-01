//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

struct WeatherTodayContentView: View {
    //MARK: Private properties
    @State private var isContentViewVisible = false
    @State private var isWeatherTodayViewVisible = false
    @EnvironmentObject private var viewModel: WeatherTodayViewModel
    
    var body: some View {
        VStack {
            switch viewModel.authorizationStatus {
            case .loading:
                ProgressView()
            case .authorized:
                if let error = viewModel.serviceError {
                    AppStateView(state: .serviceError(error))
                } else {
                    WeatherTodayView()
                        .onAppear {
                            if !isWeatherTodayViewVisible {
                                isWeatherTodayViewVisible = true
                                viewModel.requestLocationAndNetworkData()
                            }
                        }
                }
            default:
                AppStateView(state: .location)
            }
        }
        .onAppear {
            if !isContentViewVisible {
                isContentViewVisible = true
                viewModel.subscribeForAuthorizationStatusUpdate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTodayContentView()
            .environmentObject(WeatherTodayViewModel(locationService: DefaultLocationService()))
            .previewDevice("iPhone 12 Pro Max")
//        WeatherTodayContentView(viewModel: WeatherTodayViewModel())
//            .previewDevice("iPhone 12")
//        WeatherTodayContentView(viewModel: WeatherTodayViewModel())
//            .previewDevice("iPhone 11")
//        WeatherTodayContentView(viewModel: WeatherTodayViewModel())
//            .previewDevice("iPhone SE (2nd generation)")
//        WeatherTodayContentView(viewModel: WeatherTodayViewModel())
//            .previewDevice("iPhone SE (2nd generation)")
    }
}
