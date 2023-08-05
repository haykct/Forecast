//
//  WeatherDetailContainerView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import SwiftUI

struct WeatherDetailContainerView: View {
    //MARK: Private properties
    private let viewData: WeatherTodayViewData

    //MARK: Initializers
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
                              text: "Humidity")
            Spacer()
            WeatherDetailView(image: "TodayPrecipitationLight",
                              value: viewData.precipitation,
                              text: "Precipitation")
            Spacer()
            WeatherDetailView(image: "TodayPressureLight",
                              value: viewData.pressure,
                              text: "Pressure")
        }
        Spacer()
        HStack {
            WeatherDetailView(image: "TodayWindSpeedLight",
                              value: viewData.wind,
                              text: "Wind")
            Spacer()
            WeatherDetailView(image: "TodayWindDirectionLight",
                              value: viewData.direction,
                              text: "Direction")
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
