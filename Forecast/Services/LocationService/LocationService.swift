//
//  LocationService.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import CoreLocation
import Combine

extension LocationService: CLLocationManagerDelegate {
    //MARK: Public methods
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

final class LocationService: NSObject {
    enum AuthorizationStatus: String {
        case loading
        case authorized
        case appLocationDenied
        case locationServicesDenied
        case notDetermined
        case restricted
    }
    
    //MARK: Typealiases
    typealias Location = PassthroughSubject<(lat: CLLocationDegrees, long: CLLocationDegrees), Error>
    typealias Status = CurrentValueSubject<AuthorizationStatus, Never>

    //MARK: Public properties
    let authorizationStatus = Status(.loading)
    let location = Location()

    //MARK: Private properties
    private let locationManager = CLLocationManager()

    //MARK: Initializers
    override init() {
        super.init()

        setupLocationManager()
    }

    //MARK: Private methods
    private func setupLocationManager() {
        locationManager.delegate = self
        // Since there is no need for high accuracy, we can set this value
        // to increase the response speed of the location.
        locationManager.desiredAccuracy = 70
    }

    private func getAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationStatus.value = .authorized
        case .denied:
            DispatchQueue.global().async {
                // In case of calling this methods on the main thread compiler warns about UI unresponsiveness.
                // We can move it to a background thread.
                let isLocationServicesEnables = CLLocationManager.locationServicesEnabled()

                DispatchQueue.main.async {
                    self.authorizationStatus.value = isLocationServicesEnables ? .appLocationDenied : .locationServicesDenied
                }
            }
        case .notDetermined:
            authorizationStatus.value = .notDetermined
        case .restricted:
            authorizationStatus.value = .restricted
        default:
            break
        }
    }

    //MARK: Public methods
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}
