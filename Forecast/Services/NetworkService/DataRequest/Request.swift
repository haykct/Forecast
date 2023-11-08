//
//  Request.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import Alamofire

protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var parameters: Parameters { get }
}

extension Request {
    var url: String { baseURL + path }
    var baseURL: String { BaseUrls.weatherApi }
}
