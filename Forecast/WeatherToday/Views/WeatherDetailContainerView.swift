//
//  WeatherDetailContainerView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import SwiftUI

struct WeatherDetailContainerView: View {
    // MARK: Private properties
    private let viewData: WeatherTodayViewData

    // MARK: Initializers
    init(viewData: WeatherTodayViewData) {
        self.viewData = viewData
    }

    var body: some View {
        var viewData = viewData // Declared as a var because a lazy var inside a struct is mutable.

        Divider()
        Spacer()
        HStack {
            WeatherDetailView(image: "TodayHumidityLight",
                              value: viewData.humidity,
                              textKey: "humidity")
            Spacer()
            WeatherDetailView(image: "TodayPrecipitationLight",
                              value: viewData.precipitation,
                              textKey: "precipitation")
            Spacer()
            WeatherDetailView(image: "TodayPressureLight",
                              value: viewData.pressure,
                              textKey: "pressure")
        }
        Spacer()
        HStack {
            WeatherDetailView(image: "TodayWindSpeedLight",
                              value: viewData.wind,
                              textKey: "wind")
            Spacer()
            WeatherDetailView(image: "TodayWindDirectionLight",
                              value: viewData.direction,
                              textKey: "direction")
            Spacer()
            Rectangle()
                .frame(width: 85, height: 0)
                .hidden()
        }
        Spacer()
        Divider()
    }
}

struct WeatherDetailContainerView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
