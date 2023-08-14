//
//  WeatherTodayView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct AppStateDescriptionView: View {
    //MARK: Enums
    enum CurrentState: Equatable {
        case location
        case serviceError(ServiceError)

        var description: String {
            switch self {
            case .location:
                return "Give us permission to see forecast for your current location."
            case .serviceError(let error):
                return error.description
            }
        }

        var firstLineText: String {
            self == .location ? "Enable" : "Error"
        }

        var secondLineText: String {
            self == .location ? "location" : "fetching"
        }

        var imageName: String {
            self == .location ? "location" : "warning"
        }
    }

    //MARK: Private properties
    private var state: CurrentState

    //MARK: Initializers
    init(state: CurrentState) {
        self.state = state
    }

    var body: some View {
        VStack(alignment: .leading) {
            let Inter = Constants.Fonts.Inter.self
            let titleFont = Font.custom(Inter.bold, size: 64)

            Image(state.imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .frame(width: 43, height: 43)
                .padding(.top, 7)
            Spacer()
            Text(state.firstLineText)
                .font(titleFont)
            Text(state.secondLineText)
                .font(titleFont)
                .padding(.top, -52)

            if state != .location {
                Text("data")
                    .font(titleFont)
                    .padding(.top, -52)
            }

            Spacer()
            Text(state.description)
                .font(Font.custom(Inter.medium, size: 16))
                .lineSpacing(4)
            Spacer()
        }
    }
}
