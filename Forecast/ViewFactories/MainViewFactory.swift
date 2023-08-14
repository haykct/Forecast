//
//  MainViewFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 12.08.23.
//

import SwiftUI

struct MainViewFactory: ViewFactory {
    func makeView() -> some View {
        let service = DefaultLocationService()
        let viewModel = MainViewModel(locationService: service)
        let view = MainView(viewModel: viewModel)

        return view
    }
}
