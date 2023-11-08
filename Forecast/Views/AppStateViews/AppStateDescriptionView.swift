//
//  AppStateDescriptionView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct AppStateDescriptionView: View {
    // MARK: Enums

    enum CurrentState: Equatable {
        case location
        case serviceError(ServiceError)

        var descriptionKey: String {
            switch self {
            case .location:
                return "location_permission"
            case let .serviceError(error):
                return error.descriptionKey
            }
        }

        var titleText: String {
            self == .location ? "enable_location" : "error_fetching_data"
        }

        var imageName: String {
            self == .location ? "location" : "warning"
        }
    }

    // MARK: Private properties

    private var state: CurrentState

    // MARK: Initializers

    init(state: CurrentState) {
        self.state = state
    }

    var body: some View {
        VStack(alignment: .leading) {
            let titleFont: Font = .custom(Fonts.Inter.bold, size: 64)

            Image(state.imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .frame(width: 43, height: 43)
                .padding(.top, 7)
            Spacer()
            Text(state.titleText.localized)
                .font(titleFont)
            Spacer()
            Text(state.descriptionKey.localized)
                .font(.custom(Fonts.Inter.medium, size: 16))
                .lineSpacing(4)
            Spacer()
        }
    }
}
