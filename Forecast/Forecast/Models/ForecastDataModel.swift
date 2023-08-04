//
//  ForecastModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

struct ForecastDataModel: Decodable {
    let forecast: ForecastListModel
}

struct ForecastListModel: Decodable {
    let forecastList: [ForecastModel]

    enum CodingKeys: String, CodingKey {
        case forecastList = "time"
    }
}

struct ForecastModel: Decodable {
    let temperature: Double?
    let upcomingDateTime: String?
    let condition: String?

    enum FirstLevelKeys: String, CodingKey {
        case to, symbol, temperature
    }

    enum SecondLevelKeys: String, CodingKey {
        case name, value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirstLevelKeys.self)
        let symbolContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .symbol)
        let temperatureContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .temperature)

        upcomingDateTime = try? container.decode(String.self, forKey: .to)
        temperature = try? temperatureContainer.decode(Double.self, forKey: .value)
        condition = try? symbolContainer.decode(String.self, forKey: .name)
    }
}
