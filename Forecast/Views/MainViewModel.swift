//
//  LocationViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 12.08.23.
//

import Combine

final class MainViewModel: ObservableObject {
    //MARK: Public properties
    @Published private(set) var authorizationStatus: AuthorizationStatus = .loading

    //MARK: Private properties
    @Injected private var locationService: LocationService

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
