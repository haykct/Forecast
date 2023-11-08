//
//  String.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.10.23.
//

extension String {
    var localized: String {
        String(localized: String.LocalizationValue(self))
    }
}
