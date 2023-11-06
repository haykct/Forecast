//
//  ErrorView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 14.08.23.
//

import SwiftUI

// Using generic type for making ErrorView reusable
struct ErrorView<T: ViewModel>: View {
    // MARK: Private properties

    @ObservedObject private var viewModel: T
    @State private var shouldAnimateGradient = false

    private let serviceError: ServiceError

    // MARK: Private initializers

    init(viewModel: T, serviceError: ServiceError) {
        self.serviceError = serviceError
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: SwiftUIColors.StateGradientColors.red,
                           startPoint: shouldAnimateGradient ? .topTrailing : .topLeading,
                           endPoint: shouldAnimateGradient ? .bottomLeading : .bottomTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                    shouldAnimateGradient.toggle()
                }
            }

            HStack {
                ReloadButton {
                    viewModel.requestLocationAndNetworkData()
                }
                .padding(.trailing, 24)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 16)

            let screenHeight = UIScreen.main.bounds.height
            let contentHeight: CGFloat = screenHeight > 667 ? 400 : 352
            let topPadding: CGFloat = screenHeight == 568 ? 80 : 100

            AppStateDescriptionView(state: .serviceError(serviceError))
                .frame(maxWidth: .infinity, maxHeight: contentHeight, alignment: .leading)
                .padding(EdgeInsets(top: topPadding, leading: 24, bottom: 0, trailing: 24))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
