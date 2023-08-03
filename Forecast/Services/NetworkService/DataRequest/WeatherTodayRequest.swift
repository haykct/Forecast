//
//  WeatherTodayRequest.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import Alamofire

struct WeatherTodayRequest: Request {
    //MARK: Private properties
    private let coordinates: (lat: Double, long: Double)
    // As the github repository is private I decided to keep apiKey in plist.
    // However, it's better to use some obfuscation techniques to keep the key more secure.
    private let apiKey = try? PlistReader.getValue(for: "apiKey")

    //MARK: Private properties
    var path: String { "data/2.5/weather" }

    var parameters: Parameters {
        [
            "units": "metric",
            "mode": "xml",
            "lat": coordinates.lat,
            "lon": coordinates.long,
            "appid": apiKey ?? ""
        ]
    }

    init(coordinates: (lat: Double, long: Double)) {
        self.coordinates = coordinates
    }
    
}
