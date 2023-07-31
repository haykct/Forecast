//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

struct WeatherTodayContentView: View {
    //MARK: Private properties
    @State private var isAppeared = false
    @EnvironmentObject private var viewModel: WeatherTodayViewModel
    
    var body: some View {
        VStack {
            switch viewModel.authorizationStatus {
            case .loading:
                ProgressView()
            case .authorized:
                EmptyView()
                    .onReceive(viewModel.$authorizationStatus, perform: { status in
                        if status == .authorized {
                            viewModel.requestLocationAndNetworkData()
                        }
                    })
            default:
                AppStateView()
            }
        }
        .onAppear {
            if !isAppeared {
                isAppeared = true
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
