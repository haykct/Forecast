//
//  LocationView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 14.08.23.
//

import SwiftUI

struct LocationView: View {
    //MARK: Private properties
    @Environment(\.openURL) private var openURL
    @ObservedObject private var viewModel: MainViewModel
    @State private var isAlertVisible = false
    @State private var title = ""
    @State private var message = ""
    @State private var shouldAnimateGradient = false

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: Constants.SwiftUIColors.StateColors.blue,
                           startPoint: shouldAnimateGradient ? .topTrailing : .topLeading,
                           endPoint: shouldAnimateGradient ? .bottomLeading : .bottomTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                    shouldAnimateGradient.toggle()
                }
            }

            let screenHeight = UIScreen.main.bounds.height
            let contentHeight: CGFloat = screenHeight > 667 ? 400 : 352
            let topPadding: CGFloat = screenHeight == 568 ? 80 : 100
            
            VStack(alignment: .leading) {
                AppStateDescriptionView(state: .location)
                CornerRoundedButton("Enable location") {
                    openAlert()
                }
                .alert(title, isPresented: $isAlertVisible, actions: {
                    Button("Settings", action: {
                        // Opening settings to turn on location services.
                        // I'm testing on simulator which doesn't support location settings,
                        // therefore I'm opening settings instead of app location settings or location services settings.
                        openURL(URL(string: UIApplication.openSettingsURLString)!)
                    })
                    Button("Cancel", action: {})
                }, message: {
                    Text(message)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: contentHeight, alignment: .leading)
            .padding(EdgeInsets(top: topPadding, leading: 24, bottom: 0, trailing: 24))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    //MARK: Private methods
    private func openAlert() {
        switch viewModel.authorizationStatus {
        case .notDetermined:
            isAlertVisible = false
            viewModel.requestAuthorization()
        case .appLocationDenied:
            isAlertVisible = true
            title = "Location service for \"Forecast\" is off"
            message = "Turn on your location settings in \"Forecast\" to determine your location."
        case .locationServicesDenied:
            isAlertVisible = true
            title = "Location Services are off"
            message = "Turn on Location Services to allow \"Forecast\" to determine your location."
        case .restricted:
            isAlertVisible = true
            title = "Location is restricted"
            message = "Change restriction settings to allow \"Forecast\" to determine your location."
        default:
            isAlertVisible = false
            break
        }
    }
}
