//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 03.08.23.
//

import UIKit

class ForecastViewController: UIViewController {
    //MARK: Private properties
    private let viewModel: ForecastViewModel

    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestLocationAndNetworkData()
    }

    //MARK: Initializers
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:)` to initialize an `ForecastViewController` instance.")
    }

    init?(coder: NSCoder, viewModel: ForecastViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }

}
