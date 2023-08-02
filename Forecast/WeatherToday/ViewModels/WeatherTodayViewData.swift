//
//  WeatherTodayViewData.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 02.08.23.
//

struct WeatherTodayViewData {
    //MARK: Private properties
    private let model: WeatherTodayModel
    private let empty = "N/A"

    //MARK: Initializers
    init(model: WeatherTodayModel) {
        self.model = model
    }

    //MARK: Public properties
    lazy var temperature: String = {
        guard let temperature = model.temperature else { return empty }

        return String(Int(temperature)) + "\u{00B0}"
    }()

    lazy var humidity: String = {
        guard let humidity = model.humidity else { return empty }

        return String(Int(humidity)) + "%"
    }()

    lazy var precipitation: String = {
        guard let precipitation = model.precipitation else { return "0.0MM" }

        return String(format:"%.1f", precipitation) + "MM"
    }()

    lazy var pressure: String = {
        guard let pressure = model.pressure else { return empty }

        return String(Int(pressure)) + " hPa"
    }()

    lazy var wind: String = {
        guard let wind = model.wind else { return empty }

        return String(Int(wind * 3.6)) + " KM/H"
    }()

    lazy var direction: String = {
        model.direction ?? empty
    }()
}
