//
//  TodayWeatherViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import Combine

class WeatherTodayViewModel: ObservableObject {

    @Published var authorizationStatus: LocationService.AuthorizationStatus = .loading

    private var locationService = LocationService()
    private var cancellable: AnyCancellable?

    func subscribeForAuthorizationStatusUpdate() {
        // Subscribing for getting authorization status updates,
        // since users can change the status from settings while the app is running
        locationService.authorizationStatus
            .assign(to: &$authorizationStatus)
    }

    func requestAuthorization() {
        locationService.requestWhenInUseAuthorization()
    }

    func requestData() {
        cancellable = locationService.location
            .sink { error in

            } receiveValue: { location in
                print(location.lat, location.long)
            }

        locationService.requestLocation()
    }
}
