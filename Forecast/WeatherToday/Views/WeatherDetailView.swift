//
//  WeatherDetailView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 02.08.23.
//

import SwiftUI

struct WeatherDetailView: View {
    // MARK: Private properties

    private let screenHeight = UIScreen.main.bounds.height
    private let image: String
    private let value: String
    private let textKey: String

    // MARK: Initializers

    init(image: String, value: String, textKey: String) {
        self.image = image
        self.value = value
        self.textKey = textKey
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if screenHeight != 568 {
                Image(image)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .padding(9)
                    .background(SwiftUIColors.detailsGrey)
                    .cornerRadius(40)
            }

            Text(value)
                .lineLimit(1)
                .font(.custom(Fonts.Inter.medium, size: 14))
                .padding(.top, 8)
            Text(textKey.localized)
                .lineLimit(1)
                .font(.custom(Fonts.Inter.medium, size: 14))
                .padding(.top, 5)
                .foregroundColor(SwiftUIColors.textGrey)
        }
        .frame(width: 85, alignment: .leading)
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(image: "", value: "", textKey: "")
    }
}
