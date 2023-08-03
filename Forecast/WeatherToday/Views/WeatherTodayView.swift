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
                    .padding(.bottom, 48)
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
                    .padding(.bottom, 40)
                    .lineLimit(1)
                VStack {
                    WeatherDetailContainerView(viewData: viewData)
                }
                .frame(height: detailContainerHeight)
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
