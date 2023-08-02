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
    @Published private(set) var viewData: WeatherTodayViewData?

    //MARK: Private properties
    private let locationService: LocationService
    private let networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()

    init(locationService: LocationService, networkService: NetworkService) {
        self.locationService = locationService
        self.networkService = networkService
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
            .flatMap { [unowned self] coordinates -> AnyPublisher<WeatherTodayModel, NetworkError> in
                let request = WeatherTodayRequest(coordinates: coordinates)

                return networkService.request(request)
            }
            .sink { [unowned self] completion in
                if case .failure(let error) = completion { serviceError = .networkError(error) }
            } receiveValue: { [unowned self] model in
                serviceError = nil
                viewData = WeatherTodayViewData(model: model)
            }
            .store(in: &cancellables)

        locationService.locationErrorSubject
            .sink { [unowned self] error in
                serviceError = .locationError
            }
            .store(in: &cancellables)
        
        locationService.requestLocation()
    }
}
