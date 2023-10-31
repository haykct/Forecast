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
                CornerRoundedButton("enable_location") {
                    openAlert()
                }
                .alert(title.localized, isPresented: $isAlertVisible, actions: {
                    Button("settings", action: {
                        // Opening settings to turn on location services.
                        // I'm testing on simulator which doesn't support location settings,
                        // therefore I'm opening settings instead of app location settings or location services settings.
                        openURL(URL(string: UIApplication.openSettingsURLString)!)
                    })
                    Button("cancel", action: {})
                }, message: {
                    Text(message.localized)
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
            title = "forecast_location_off"
            message = "turn_on_location_settings"
        case .locationServicesDenied:
            isAlertVisible = true
            title = "location_off"
            message = "turn_on_location_services"
        case .restricted:
            isAlertVisible = true
            title = "location_restricted"
            message = "change_restriction_settings"
        default:
            isAlertVisible = false
            break
        }
    }
}
