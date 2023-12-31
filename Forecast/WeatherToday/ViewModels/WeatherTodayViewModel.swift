//
//  WeatherTodayViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import Combine

final class WeatherTodayViewModel: ObservableObject, ViewModel {
    // MARK: Public properties

    @Published private(set) var serviceError: ServiceError?
    @Published private(set) var viewData: WeatherTodayViewData?

    // MARK: Private properties

    @Injected private var networkService: NetworkService
    @Injected private var locationService: LocationService
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializers

    init() {
        setupLocationSubjects()
    }

    // MARK: Public methods

    func requestLocationAndNetworkData() {
        locationService.requestLocation()
    }

    // MARK: Private methods

    private func setupLocationSubjects() {
        locationService.locationSubject
            .flatMap { [unowned self] coordinates -> AnyPublisher<WeatherTodayModel, Never> in
                let request = WeatherTodayRequest(coordinates: coordinates)

                return networkService.request(request)
                    .catch { [unowned self] error in
                        serviceError = .networkError(error)

                        return Empty<WeatherTodayModel, Never>()
                    }
                    .eraseToAnyPublisher()
            }
            .sink(receiveValue: { [unowned self] model in
                serviceError = nil
                viewData = WeatherTodayViewData(model: model)
            })
            .store(in: &cancellables)

        locationService.locationErrorSubject
            .sink { [unowned self] _ in
                serviceError = .locationError
            }
            .store(in: &cancellables)
    }
}
