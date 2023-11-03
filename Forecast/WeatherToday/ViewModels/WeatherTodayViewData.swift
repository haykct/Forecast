//
//  WeatherTodayViewData.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 02.08.23.
//

struct WeatherTodayViewData {
    //MARK: Private properties
    private let model: WeatherTodayModel

    //MARK: Initializers
    init(model: WeatherTodayModel) {
        self.model = model
    }

    //MARK: Public properties
    private(set) lazy var location: String = {
        if let city = model.city?.name, let country = model.city?.country {
            return "\(city), \(country)"
        }

        return model.city?.name ?? model.city?.country ?? LocalizationKeys.notAvailable
    }()

    private(set) lazy var temperatureValue: Int? = {
        guard let temp = model.temperature?.value else { return nil }

        return Int(temp)
    }()

    private(set) lazy var temperature: String = {
        guard let temperature = model.temperature?.value else { return LocalizationKeys.notAvailable }

        return String(Int(temperature)) + "\u{00B0}C"
    }()

    private(set) lazy var humidity: String = {
        guard let humidity = model.humidity?.value else { return LocalizationKeys.notAvailable }

        return String(Int(humidity)) + "%"
    }()

    private(set) lazy var precipitation: String = {
        guard let precipitation = model.precipitation?.value else { return "0.0MM" }

        return String(format:"%.1f", precipitation) + "MM"
    }()

    private(set) lazy var precipitationMode: String = {
        model.precipitation?.mode ?? LocalizationKeys.notAvailable
    }()

    private(set) lazy var pressure: String = {
        guard let pressure = model.pressure?.value else { return LocalizationKeys.notAvailable }

        return String(Int(pressure)) + " hPa"
    }()

    private(set) lazy var wind: String = {
        guard let wind = model.wind?.speed?.value else { return LocalizationKeys.notAvailable }

        return String(Int(wind * 3.6)) + " KM/H"
    }()

    private(set) lazy var direction: String = {
        model.wind?.direction?.code ?? LocalizationKeys.notAvailable
    }()
}
