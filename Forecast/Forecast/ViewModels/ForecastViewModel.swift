//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Combine

final class ForecastViewModel: ViewModel {
    //MARK: Public properties
    private(set) var viewData = CurrentValueSubject<[[ForecastViewData]], Never>([])

    //MARK: Private properties
    private let locationService: LocationService
    private let networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()

    //MARK: Initializers
    init(locationService: LocationService, networkService: NetworkService) {
        self.locationService = locationService
        self.networkService = networkService
    }
    
    //MARK: Public methods
    func requestLocationAndNetworkData() {
        setupLocationSubjects()
        locationService.requestLocation()
    }

    //MARK: Private methods
    private func setupLocationSubjects() {
        cancellables.removeAll()
        
        locationService.locationSubject
            .flatMap { [unowned self] coordinates -> AnyPublisher<ForecastDataModel, NetworkError> in
                let request = ForecastRequest(coordinates: coordinates)

                return networkService.request(request)
            }
            .sink { completion in
            } receiveValue: { [unowned self] model in
                let forecastViewData = ForecastViewData.makeViewData(model: model)

                viewData.value = forecastViewData
            }
            .store(in: &cancellables)
    }
}
