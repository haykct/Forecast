//
//  WeatherTodayView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct AppStateView<T: ViewModel>: View {
    //MARK: Enums
    enum CurrentState: Equatable {
        case location
        case serviceError(ServiceError)

        var description: String {
            switch self {
            case .location:
                return "Give us permission to see forecast for your current location."
            case .serviceError(let error):
                return error.description
            }
        }

        var firstLineText: String {
            self == .location ? "Enable" : "Error"
        }

        var secondLineText: String {
            self == .location ? "location" : "fetching"
        }

        var imageName: String {
            self == .location ? "location" : "warning"
        }
    }

    //MARK: Private properties
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var viewModel: T
    @State private var isAlertVisible = false
    @State private var title = ""
    @State private var message = ""

    private var state: CurrentState

    //MARK: Initializers
    init(state: CurrentState) {
        self.state = state
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            let screenHeight = UIScreen.main.bounds.height
            let contentHeight: CGFloat = screenHeight > 667 ? 400 : 352
            let topPadding: CGFloat = screenHeight == 568 ? 80 : 100

            if state != .location {
                HStack {
                    ReloadButton {
                        viewModel.requestLocationAndNetworkData()
                    }
                    .padding(.trailing, 24)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 16)
            }

            VStack(alignment: .leading) {
                let Inter = Constants.Fonts.Inter.self
                let titleFont = Font.custom(Inter.bold, size: 64)

                Image(state.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: 43, height: 43)
                    .padding(.top, 7)
                Spacer()
                Text(state.firstLineText)
                    .font(titleFont)
                Text(state.secondLineText)
                    .font(titleFont)
                    .padding(.top, -52)

                if state != .location {
                    Text("data")
                        .font(titleFont)
                        .padding(.top, -52)
                }

                Spacer()
                Text(state.description)
                    .font(Font.custom(Inter.medium, size: 16))
                    .lineSpacing(4)
                Spacer()

                if state == .location {
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

struct AppStateView_Previews: PreviewProvider {
    static var previews: some View {
//        AppStateView<ForecastViewModel>(state: .serviceError(.locationError))
//            .previewDevice("iPhone SE (1st generation)")
//            .environmentObject(WeatherTodayViewModel(locationService: DefaultLocationService(),
//                                                     networkService: DefaultNetworkService()))
        EmptyView()
    }
}
