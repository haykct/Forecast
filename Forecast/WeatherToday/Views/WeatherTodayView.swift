//
//  WeatherTodayView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import SwiftUI

struct WeatherTodayView: View {
    // MARK: Enums

    enum Precipitation: String {
        case rain
        case snow
        case clear = "no"
    }

    // MARK: Structs

    struct Dimension {
        private let _detailContainerHeight: CGFloat
        private let _titleBottomPadding: CGFloat
        private let _locationBottomPadding: CGFloat

        var detailContainerHeight: CGFloat { _detailContainerHeight }
        var titleBottomPadding: CGFloat { _titleBottomPadding }
        var locationBottomPadding: CGFloat { _locationBottomPadding }

        init(screenHeight: CGFloat) {
            switch screenHeight {
            case 667:
                _titleBottomPadding = 24
                _locationBottomPadding = 24
                _detailContainerHeight = 208
            case 568:
                _titleBottomPadding = 16
                _locationBottomPadding = 16
                _detailContainerHeight = 124
            default:
                _titleBottomPadding = 48
                _locationBottomPadding = 40
                _detailContainerHeight = 248
            }
        }
    }

    // MARK: Private properties

    @ObservedObject private var viewModel: WeatherTodayViewModel
    @State private var shouldAnimateGradient = false

    private let dimension = Dimension(screenHeight: UIScreen.main.bounds.height)

    // MARK: Initializers

    init(viewModel: WeatherTodayViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if var viewData = viewModel.viewData {
            ZStack {
                let stateColors = SwiftUIColors.StateGradientColors.self
                let isSunny = viewData.precipitationMode == Precipitation.clear.rawValue

                LinearGradient(colors: isSunny ? stateColors.yellow : stateColors.blue,
                               startPoint: shouldAnimateGradient ? .topTrailing : .topLeading,
                               endPoint: shouldAnimateGradient ? .bottomLeading : .bottomTrailing)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                        shouldAnimateGradient.toggle()
                    }
                }

                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        CornerRoundedButton("share", style: .light) {}
                            .frame(alignment: .trailing)
                            .padding(.top, 16)
                            .padding(.trailing, 24)
                    }

                    Spacer()

                    createTitleText(viewData)
                    createIconImage(viewData)

                    Text(viewData.temperature)
                        .font(.custom(Fonts.Inter.semiBold, size: 32))
                        .padding(.bottom, 8)
                    Text(viewData.location)
                        .font(.custom(Fonts.Inter.regular, size: 16))
                        .foregroundColor(SwiftUIColors.textGrey)
                        .padding(.bottom, dimension.locationBottomPadding)
                        .lineLimit(1)
                    VStack {
                        WeatherDetailContainerView(viewData: viewData)
                    }
                    .frame(height: dimension.detailContainerHeight)
                    .padding(.bottom, 25)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding([.leading, .trailing], 24)
            }
        } else {
            ProgressView("loading")
                .controlSize(.large)
        }
    }

    // MARK: Private methods

    private func createTitleText(_ viewData: WeatherTodayViewData) -> some View {
        var viewData = viewData
        var title = LocalizationKeys.notAvailable

        switch viewData.precipitationMode {
        case Precipitation.rain.rawValue, Precipitation.snow.rawValue:
            title = viewData.precipitationMode
        case Precipitation.clear.rawValue:
            guard let temp = viewData.temperatureValue else { break }

            title = temp > 29 ? "hot" : "sunny"
        default:
            break
        }

        return VStack(alignment: .leading, spacing: 0) {
            Text(title.localized)
                .font(.custom(Fonts.Inter.bold, size: 64))
                .padding(.bottom, dimension.titleBottomPadding)
        }
    }

    private func createIconImage(_ viewData: WeatherTodayViewData) -> some View {
        var viewData = viewData
        let imageName: String

        switch viewData.precipitationMode {
        case Precipitation.rain.rawValue:
            imageName = "TodayRainLight"
        case Precipitation.snow.rawValue:
            imageName = "TodaySnowLight"
        case Precipitation.clear.rawValue:
            imageName = "TodaySunLight"
        default:
            imageName = ""
        }

        return Image(imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .padding(.bottom, 4)
    }
}
