//
//  LocationService.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import CoreLocation
import Combine

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print(latitude, longitude, locations.count)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        getAuthorizationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

class LocationService: NSObject {
    enum AuthorizationStatus: String {
        case loading
        case authorized
        case appLocationDenied
        case locationServicesDenied
        case notDetermined
        case restricted
    }
    
    typealias Location = PassthroughSubject<(lat: CLLocationDegrees, long: CLLocationDegrees), Error>
    typealias Status = CurrentValueSubject<AuthorizationStatus, Never>

    let authorizationStatus = Status(.loading)
    let location = Location()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()

        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        // Since there is no need for high accuracy, we can set this value
        // to increase the response speed of the location
        locationManager.desiredAccuracy = 70
    }

    private func getAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationStatus.value = .authorized
        case .denied:
            let isLocationServicesEnables = CLLocationManager.locationServicesEnabled()

            authorizationStatus.value = isLocationServicesEnables ? .appLocationDenied : .locationServicesDenied
        case .notDetermined:
            authorizationStatus.value = .notDetermined
        case .restricted:
            authorizationStatus.value = .restricted
        default:
            break
        }
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}
