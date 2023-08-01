//
//  TodayWeatherViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import Combine

final class WeatherTodayViewModel: ObservableObject {
    //MARK: Public properties
    @Published private(set) var authorizationStatus: AuthorizationStatus = .loading
    @Published private(set) var serviceError: ServiceError?

    //MARK: Private properties
    private let locationService: any LocationService
    private var cancellables = Set<AnyCancellable>()

    init(locationService: any LocationService) {
        self.locationService = locationService
    }

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
            .sink(receiveValue: { [weak self] coordinates in
                print(coordinates)
                self?.serviceError = nil
            })
            .store(in: &cancellables)

        locationService.locationErrorSubject
            .sink { [weak self] error in
                self?.serviceError = .locationError
            }
            .store(in: &cancellables)
        
        locationService.requestLocation()
    }

    #warning("Remove deinit")
    deinit {
        print("deinit")
    }
}
