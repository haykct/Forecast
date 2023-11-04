//
//  LocationService.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import Combine
import CoreLocation

// MARK: Enums

enum AuthorizationStatus {
    case loading
    case authorized
    case appLocationDenied
    case locationServicesDenied
    case notDetermined
    case restricted
}

enum Subjects {
    typealias LocationSubject = PassthroughSubject<(lat: CLLocationDegrees, long: CLLocationDegrees), Never>
    // If I send error to LocationSubject, the subscription will be cancelled which is not what I want.
    // I want to get location updates even after getting an error.
    // That's the reason I created LocationErrorSubject separate subject for sending errors to downstream.
    typealias LocationErrorSubject = PassthroughSubject<Error, Never>
    typealias StatusSubject = CurrentValueSubject<AuthorizationStatus, Never>
}

// MARK: Protocols

protocol LocationService {
    var authorizationStatusSubject: Subjects.StatusSubject { get }
    var locationSubject: Subjects.LocationSubject { get }
    var locationErrorSubject: Subjects.LocationErrorSubject { get }

    func requestWhenInUseAuthorization()
    func requestLocation()
}

final class DefaultLocationService: NSObject, LocationService {
    // MARK: Public properties

    var authorizationStatusSubject = Subjects.StatusSubject(.loading)
    var locationSubject = Subjects.LocationSubject()
    var locationErrorSubject = Subjects.LocationErrorSubject()

    // MARK: Private properties

    private let locationManager: CLLocationManager

    // MARK: Initializers

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager

        super.init()
        setupLocationManager()
    }

    // MARK: Private methods

    private func setupLocationManager() {
        locationManager.delegate = self
        // Since there is no need for high accuracy, we can set this value
        // to increase the response speed of the location.
        locationManager.desiredAccuracy = 70
    }

    private func getAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationStatusSubject.value = .authorized
        case .denied:
            DispatchQueue.global().async {
                // In case of calling this methods on the main thread compiler warns about UI unresponsiveness.
                // We can move it to a background thread.
                let isLocationServicesEnables = CLLocationManager.locationServicesEnabled()

                DispatchQueue.main.async {
                    self.authorizationStatusSubject.value = isLocationServicesEnables
                        ? .appLocationDenied
                        : .locationServicesDenied
                }
            }
        case .notDetermined:
            authorizationStatusSubject.value = .notDetermined
        case .restricted:
            authorizationStatusSubject.value = .restricted
        default:
            break
        }
    }

    // MARK: Public methods

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension DefaultLocationService: CLLocationManagerDelegate {
    // MARK: Public methods

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            locationManager.stopUpdatingLocation()
            locationSubject.send((lat: coordinate.latitude, long: coordinate.longitude))
        }
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        locationErrorSubject.send(error)
    }

    func locationManagerDidChangeAuthorization(_: CLLocationManager) {
        getAuthorizationStatus()
    }
}
