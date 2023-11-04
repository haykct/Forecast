//
//  DateManager.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 04.08.23.
//

import Foundation

struct DateManager {
    // MARK: Private properties
    private let formatter = DateFormatter()

    init() {
        formatter.timeZone = TimeZone.current
        formatter.locale = .current
    }

    // MARK: Public methods
    func date(from string: String, format: String) -> Date? {
        formatter.dateFormat = format

        return formatter.date(from: string)
    }

    func string(from date: Date, format: String) -> String {
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
}
