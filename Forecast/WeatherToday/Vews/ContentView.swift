//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherTodayViewModel()

    var body: some View {
        VStack {
            Text(viewModel.authorizationStatus.rawValue)
            Button(action: {
                viewModel.requestAuthorization()
            }) {
                Text("Button")
            }
        }
        .onReceive(viewModel.$authorizationStatus, perform: { status in
            if status == .authorized { viewModel.requestData() }
        })
        .onAppear {
            viewModel.subscribeForAuthorizationStatusUpdate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
