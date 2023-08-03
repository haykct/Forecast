//
//  WeatherTodayView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import SwiftUI

struct WeatherTodayView: View {
    //MARK: Enums
    enum Precipitation: String {
        case rain
        case snow
        case no
    }

    //MARK: Structs
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

    //MARK: Private properties
    @EnvironmentObject private var viewModel: WeatherTodayViewModel

    private let dimension = Dimension(screenHeight: UIScreen.main.bounds.height)

    var body: some View {
        if let viewData = viewModel.viewData {
            VStack(alignment: .leading, spacing: 0) {
                let Inter = Constants.Fonts.Inter.self
                let titleFont = Font.custom(Inter.bold, size: 64)

                HStack {
                    Spacer()
                    CornerRoundedButton("Share", style: .light) {}
                        .frame(alignment: .trailing)
                        .padding(.top, 16)
                        .padding(.trailing, 24)
                }

                Spacer()
                Text("It's")
                    .font(titleFont)
                    .frame(height: 64)
                Text("raining.")
                    .font(titleFont)
                    .frame(height: 64)
                    .padding(.bottom, dimension.titleBottomPadding)
                Image("TodayRainLight")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 4)
                Text("19C")
                    .font(Font.custom(Inter.semiBold, size: 32))
                    .padding(.bottom, 8)
                Text("Prague, Czech Republic")
                    .font(Font.custom(Inter.regular, size: 16))
                    .foregroundColor(Constants.SwiftUIColors.textGrey)
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
        } else {
            ProgressView("Loading")
                .controlSize(.large)
        }
    }
}

struct WeatherTodayView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTodayView()
    }
}
