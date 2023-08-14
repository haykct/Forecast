//
//  ForecastViewData.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Foundation

struct ForecastViewData {
    //MARK: Private properties
    private let dateManager = DateManager()
    private let empty = "N/A"
    private let _temperature: Double?
    private let _upcomingDateTime: Date
    private let _condition: String?
    private let _icon: String?

    //MARK: Public properties
    private(set) lazy var temperature: String = {
        guard let temperature = _temperature else { return empty }

        return String(Int(temperature)) + "\u{00B0}C"
    }()

    private(set) lazy var upcomingDate: String = {
        if Calendar.current.isDate(_upcomingDateTime, inSameDayAs: Date(timeIntervalSince1970: 0)) {
            return "N/A"
        } else {
            return dateManager.string(from: _upcomingDateTime, format: "EEEE, d MMM")
        }
    }()

    private(set) lazy var upcomingTime: String = {
        if Calendar.current.isDate(_upcomingDateTime, inSameDayAs: Date(timeIntervalSince1970: 0)) {
            return "N/A"
        } else {
            return dateManager.string(from: _upcomingDateTime, format: "h:mm a")
        }
    }()

    private(set) lazy var condition: String = {
        guard let condition = _condition, !condition.isEmpty else { return empty }

        return condition.first!.uppercased() + condition.dropFirst()
    }()

    private(set) lazy var icon: String = {
        _icon ?? ""
    }()

    //MARK: Public methods
    static func makeViewData(model: ForecastDataModel) -> [[ForecastViewData]] {
        let dateManager = DateManager()

        var viewData = model.forecast.forecastList.reduce(into: [[ForecastViewData]]()) { partialResult, forecast in
            let dateString = forecast.upcomingDateTime ?? ""
            let date = dateManager.date(from: dateString, format: "yyyy-MM-dd'T'HH:mm:ss") ?? Date(timeIntervalSince1970: 0)
            let viewData = ForecastViewData(_temperature: forecast.temperature,
                                            _upcomingDateTime: date,
                                            _condition: forecast.condition,
                                            _icon: forecast.icon)

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

            if viewData[0].isEmpty { viewData.removeFirst() }
        }

        return viewData
    }
}
