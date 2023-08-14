//
//  ForecastApp.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

@main
struct ForecastApp: App {
    var body: some Scene {
        WindowGroup {
            createMainView(factory: MainViewFactory())
        }
    }

    private func createMainView(factory: some ViewFactory) -> some View {
        factory.makeView()
    }
}
