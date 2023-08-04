//
//  Constants.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

enum Constants {
    enum Fonts {
        enum Inter {
            static let regular = "Inter-Regular"
            static let medium = "Inter-Medium"
            static let semiBold = "Inter-SemiBold"
            static let bold = "Inter-Bold"
        }
    }

    enum SwiftUIColors {
        static let detailsGrey = Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255)
        static let textGrey = Color(red: 148 / 255, green: 148 / 255, blue: 148 / 255)

        enum StateColors {
            static let blue = [Color(red: 0.39, green: 0.57, blue: 1),
                               Color(red: 0.5, green: 0.7, blue: 0.95),
                               Color(red: 0.7, green: 0.87, blue: 0.97),
                               Color(red: 0.91, green: 0.96, blue: 0.99),
                               .white, .white, .white]

            static let red = [Color(red: 0.95, green: 0.41, blue: 0.39),
                              Color(red: 0.96, green: 0.58, blue: 0.53),
                              Color(red: 0.98, green: 0.77, blue: 0.74),
                              Color(red: 0.99, green: 0.93, blue: 0.93),
                              .white, .white, .white]

            static let yellow = [Color(red: 0.98, green: 0.83, blue: 0.48),
                                 Color(red: 0.99, green: 0.93, blue: 0.62),
                                 Color(red: 0.99, green: 0.95, blue: 0.72),
                                 Color(red: 1.0, green: 0.99, blue: 0.94),
                                 .white, .white, .white]
        }
    }

    enum BaseUrls {
        static let weatherApi = "https://api.openweathermap.org/"
    }
}
