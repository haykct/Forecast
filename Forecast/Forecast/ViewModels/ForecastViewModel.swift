//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Combine

final class ForecastViewModel: ViewModel {
    // MARK: Public properties

    @Published private(set) var viewData: [[ForecastViewData]] = []

    // MARK: Private properties

    @Injected private var locationService: LocationService
    @Injected private var networkService: NetworkService
    private var cancellable: AnyCancellable?
    private weak var coordinator: ForecastCoordinator?

    // MARK: Initializers

    init(coordinator: ForecastCoordinator?) {
        self.coordinator = coordinator

        setupLocationSubjects()
    }

    // MARK: Public methods

    func requestLocationAndNetworkData() {
        locationService.requestLocation()
    }

    // MARK: Private methods

    private func setupLocationSubjects() {
        cancellable = locationService.locationSubject
            .flatMap { [unowned self] coordinates -> AnyPublisher<ForecastModel, NetworkError> in
                let request = ForecastRequest(coordinates: coordinates)

                return networkService.request(request)
            }
            .sink { _ in } receiveValue: { [unowned self] model in
                let forecastViewData = ForecastViewData.makeViewData(model: model)

                viewData = forecastViewData
            }
    }
}
