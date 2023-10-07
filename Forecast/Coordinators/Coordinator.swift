//
//  Coordinator.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 07.10.23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }

    func start()
}
