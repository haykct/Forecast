//
//  Constants.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

enum Fonts {
    enum Inter {
        static let regular = "Inter-Regular"
        static let medium = "Inter-Medium"
        static let semiBold = "Inter-SemiBold"
        static let bold = "Inter-Bold"
    }
}

enum SwiftUIColors {
    static let detailsGrey = Color(.detailsGrey)
    static let textGrey = Color(.textGrey)

    enum StateGradientColors {
        static let blue = [Color(.firstBlue),
                           Color(.secondBlue),
                           Color(.thirdBlue),
                           Color(.fourthBlue),
                           .white, .white, .white]

        static let red = [Color(.firstRed),
                          Color(.secondRed),
                          Color(.thirdRed),
                          Color(.fourthRed),
                          .white, .white, .white]

        static let yellow = [Color(.firstYellow),
                             Color(.secondYellow),
                             Color(.thirdYellow),
                             Color(.fourthYellow),
                             .white, .white, .white]
    }
}

enum BaseUrls {
    static let weatherApi = "https://api.openweathermap.org/"
}
