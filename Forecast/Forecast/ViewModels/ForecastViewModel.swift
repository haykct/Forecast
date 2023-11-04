//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Combine

final class ForecastViewModel: ViewModel {
    // MARK: Public properties
    private(set) var viewData = CurrentValueSubject<[[ForecastViewData]], Never>([])

    // MARK: Private properties
    @Injected private var locationService: LocationService
    @Injected private var networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()
    private weak var coordinator: ForecastCoordinator?

    // MARK: Initializers
    init(coordinator: ForecastCoordinator?) {
        self.coordinator = coordinator
    }

    // MARK: Public methods
    func requestLocationAndNetworkData() {
        setupLocationSubjects()
        locationService.requestLocation()
    }

    // MARK: Private methods
    private func setupLocationSubjects() {
        cancellables.removeAll()

        locationService.locationSubject
            .flatMap { [unowned self] coordinates -> AnyPublisher<ForecastModel, NetworkError> in
                let request = ForecastRequest(coordinates: coordinates)

                return networkService.request(request)
            }
            .sink { _ in } receiveValue: { [unowned self] model in
                let forecastViewData = ForecastViewData.makeViewData(model: model)

                viewData.value = forecastViewData
            }
            .store(in: &cancellables)
    }
}
