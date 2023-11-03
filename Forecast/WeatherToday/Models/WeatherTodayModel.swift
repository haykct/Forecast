//
//  WeatherTodayModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

struct WeatherTodayModel: Decodable {
    let city: City?
    let temperature: Temperature?
    let humidity: Humidity?
    let precipitation: Precipitation?
    let pressure: Pressure?
    let wind: Wind?

    struct City: Decodable {
        let country: String?
        let name: String?
    }

    struct Temperature: Decodable {
        let value: Double?
    }

    struct Humidity: Decodable {
        let value: Double?
    }

    struct Precipitation: Decodable {
        let value: Double?
        let mode: String?
    }

    struct Pressure: Decodable {
        let value: Double?
    }

    struct Wind: Decodable {
        let speed: Speed?
        let direction: Direction?

        struct Speed: Decodable {
            let value: Double?
        }

        struct Direction: Decodable {
            let code: String?
        }
    }
}
