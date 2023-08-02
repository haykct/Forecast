//
//  WeatherTodayModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

struct WeatherTodayModel: Decodable {
    let temperature: Double?
    let humidity: Double?
    let precipitation: Double?
    let precipitationMode: String?
    let pressure: Double?
    let wind: Double?
    let direction: String?

    enum FirstLevelKeys: String, CodingKey {
        case temperature, humidity, precipitation, pressure, wind
    }

    enum SecondLevelKeys: String, CodingKey {
        case value, mode, speed, direction
    }

    enum ThirdLevelKeys: String, CodingKey {
        case value, code
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FirstLevelKeys.self)
        let temperatureContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .temperature)
        let humidityContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .humidity)
        let precipitationContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .precipitation)
        let pressureContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .pressure)
        let windContainer = try container.nestedContainer(keyedBy: SecondLevelKeys.self, forKey: .wind)
        let speedContainer = try windContainer.nestedContainer(keyedBy: ThirdLevelKeys.self, forKey: .speed)
        let directionContainer = try windContainer.nestedContainer(keyedBy: ThirdLevelKeys.self, forKey: .direction)

        temperature = try? temperatureContainer.decode(Double.self, forKey: .value)
        humidity = try? humidityContainer.decode(Double.self, forKey: .value)
        precipitation = try? precipitationContainer.decode(Double.self, forKey: .value)
        precipitationMode = try? precipitationContainer.decode(String.self, forKey: .mode)
        pressure = try? pressureContainer.decode(Double.self, forKey: .value)
        wind = try? speedContainer.decode(Double.self, forKey: .value)
        direction = try? directionContainer.decode(String.self, forKey: .code)
    }
}
