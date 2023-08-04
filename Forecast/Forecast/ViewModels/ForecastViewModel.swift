//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import Combine

final class ForecastViewModel {
    //MARK: Private properties
    private let locationService: LocationService
    private let networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()

    //MARK: Initializers
    init(locationService: LocationService, networkService: NetworkService) {
        self.locationService = locationService
        self.networkService = networkService
    }
    
    //MARK: Private methods
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
            } receiveValue: { model in
//                ForecastViewData.makeViewData(model: model)
            }
            .store(in: &cancellables)
    }
}
