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

        return String(temperature.rounded()) + "\u{00B0}"
    }()

    lazy var humidity: String = {
        guard let humidity = model.humidity else { return empty }

        return String(humidity.rounded()) + "%"
    }()

    lazy var precipitation: String = {
        guard let precipitation = model.precipitation else { return "0.0MM" }

        return String(format:"%.1f", precipitation) + "MM"
    }()

    lazy var pressure: String = {
        guard let pressure = model.humidity else { return empty }

        return String(pressure.rounded()) + " hPa"
    }()

    lazy var wind: String = {
        guard let wind = model.humidity else { return empty }

        return String((wind * 3.6).rounded()) + " KM/H"
    }()

    lazy var direction: String = {
        model.direction ?? empty
    }()
}
