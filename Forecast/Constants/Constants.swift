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
    }

    enum BaseUrls {
        static let weatherApi = "https://api.openweathermap.org/"
    }
}
