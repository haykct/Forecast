//
//  ForecastViewData.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Foundation

struct DateManager {
    //MARK: Private properties
    private let formatter = DateFormatter()

    init() {
        formatter.timeZone = TimeZone.current
    }

    //MARK: Public methods
    func date(from string: String, format: String) -> Date? {
        formatter.dateFormat = format

        return formatter.date(from: string)
    }

    func string(from date: Date, format: String) -> String {
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
}

struct ForecastViewData {
    //MARK: Private properties
    private let dateManager = DateManager()
    private let empty = "N/A"
    private let _temperature: Double?
    private let _upcomingDateTime: Date
    private let _condition: String?

    //MARK: Public properties
    private(set) lazy var temperature: String = {
        guard let temperature = _temperature else { return empty }

        return String(Int(temperature)) + "\u{00B0}C"
    }()

    private(set) lazy var upcomingDate: String = {
        dateManager.string(from: _upcomingDateTime, format: "EEEE, d MMM")
    }()

    private(set) lazy var upcomingTime: String = {
        dateManager.string(from: _upcomingDateTime, format: "h:mm a")
    }()

    private(set) lazy var condition: String = {
        guard let condition = _condition, !condition.isEmpty else { return empty }

        return condition.first!.uppercased() + condition.dropFirst()
    }()

    //MARK: Public methods
    static func makeViewData(model: ForecastDataModel) -> [[ForecastViewData]] {
        let dateManager = DateManager()

        var viewData = model.forecast.forecastList.reduce(into: [[ForecastViewData]]()) { partialResult, forecast in
            let dateString = forecast.upcomingDateTime ?? ""
            let date = dateManager.date(from: dateString, format: "yyyy-MM-dd'T'HH:mm:ss") ?? Date(timeIntervalSince1970: 0)
            let viewData = ForecastViewData(_temperature: forecast.temperature,
                                            _upcomingDateTime: date,
                                            _condition: forecast.condition)

            guard let upcomingDateTime = partialResult.last?.last?._upcomingDateTime else {
                return partialResult.append([viewData])
            }

            if Calendar.current.isDate(date, inSameDayAs: upcomingDateTime) {
                partialResult[partialResult.count - 1].append(viewData)
            } else {
                partialResult.append([viewData])
            }
        }

        let firstDateTime = viewData.first?.first?._upcomingDateTime

        if firstDateTime?.compare(Date.now) == .orderedAscending {
            viewData[0].removeFirst()
        }

        return viewData
    }
}
