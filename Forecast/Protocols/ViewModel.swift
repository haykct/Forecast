//
//  ViewModel.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 04.08.23.
//

import Foundation

protocol ViewModel: ObservableObject {
    var authorizationStatus: AuthorizationStatus { get }

    func requestAuthorization()
    func requestLocationAndNetworkData()
}
