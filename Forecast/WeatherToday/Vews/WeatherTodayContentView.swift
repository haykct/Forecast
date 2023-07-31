//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

struct WeatherTodayContentView: View {
    //MARK: Private properties
    @State private var isForecastViewAppeared = false
    @State private var isWeatherTodayContentViewAppeared = false
    @EnvironmentObject private var viewModel: WeatherTodayViewModel
    
    var body: some View {
        VStack {
            switch viewModel.authorizationStatus {
            case .loading:
                ProgressView()
            case .authorized:
                EmptyView()
                    .onAppear {
                        if !isForecastViewAppeared {
                            isForecastViewAppeared = true
                            viewModel.requestData()
                        }
                    }
            case .appLocationDenied:
                AppStateView()
            case .locationServicesDenied:
                AppStateView()
            case .notDetermined:
                AppStateView()
            case .restricted:
                AppStateView()
                Text("Restricted")
            }
        }
        .onAppear {
            if !isWeatherTodayContentViewAppeared {
                isWeatherTodayContentViewAppeared = true
                viewModel.subscribeForAuthorizationStatusUpdate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTodayContentView().environmentObject(WeatherTodayViewModel())
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
