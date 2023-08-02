//
//  WeatherTodayView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import SwiftUI

struct WeatherTodayView: View {
    //MARK: Private properties
    @EnvironmentObject private var viewModel: WeatherTodayViewModel

    private let screenHeight = UIScreen.main.bounds.height
    private var detailContainerHeight: CGFloat {
        let height: CGFloat

        switch screenHeight {
        case 667:
            height = 208
        case 568:
            height = 124
        default:
            height = 248
        }

        return height
    }

    var body: some View {
        if let viewData = viewModel.viewData {
            VStack {
                renderContent(viewData: viewData)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        } else {
            ProgressView("Loading")
                .controlSize(.large)
        }
    }

    private func renderContent(viewData: WeatherTodayViewData) -> some View {
        VStack {
            var viewData = viewData //Lazy vars don't allow access from immutable values

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
                    .frame(width: 85, height: 1)
                    .hidden()
            }
            Spacer()
            Divider()
        }
        .frame(height: detailContainerHeight)
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 25, trailing: 24))
    }
}

struct WeatherTodayView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTodayView()
    }
}
