//
//  TodayWeatherViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import Combine

final class WeatherTodayViewModel: ObservableObject {
    //MARK: Public properties
    @Published private(set) var authorizationStatus: LocationService.AuthorizationStatus = .loading
    @Published private(set) var serviceError: ServiceError?

    //MARK: Private properties
    private let locationService = LocationService()
    private var cancellables = Set<AnyCancellable>()

    //MARK: Public methods
    func subscribeForAuthorizationStatusUpdate() {
        // Subscribing for getting authorization status updates,
        // since users can change the status from settings while the app is running
        locationService.authorizationStatusSubject
            .assign(to: &$authorizationStatus)
    }

    func requestAuthorization() {
        locationService.requestWhenInUseAuthorization()
    }

    func requestLocationAndNetworkData() {
        cancellables.removeAll()
        
        locationService.locationSubject
            .sink(receiveValue: { coordinates in
                print(coordinates)
            })
            .store(in: &cancellables)

        locationService.locationErrorSubject
            .sink { [weak self] error in
                self?.serviceError = .locationError
            }
            .store(in: &cancellables)
        
        locationService.requestLocation()
    }

    deinit {
        print("deinit")
    }
}
