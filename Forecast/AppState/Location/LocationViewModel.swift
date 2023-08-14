//
//  LocationViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 12.08.23.
//

import Combine

final class LocationViewModel: ObservableObject {
    //MARK: Public properties
    @Published private(set) var authorizationStatus: AuthorizationStatus = .loading
    let locationService: LocationService

    //MARK: Initializers
    init(locationService: LocationService) {
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
}
