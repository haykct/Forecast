//
//  ForecastDataModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

struct ForecastModel: Decodable {
    let forecast: Forecast
}

struct Forecast: Decodable {
    let details: [Details]

    enum CodingKeys: String, CodingKey {
        case details = "time"
    }
}

struct Details: Decodable {
    let upcomingDateTime: String?
    let temperature: Temperature?
    let weatherCondition: WeatherCondition?

    enum CodingKeys: String, CodingKey {
        case upcomingDateTime = "to", temperature, weatherCondition = "symbol"
    }
}

struct Temperature: Decodable {
    let value: Double?
}

struct WeatherCondition: Decodable {
    let icon: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case icon = "var", name
    }
}
