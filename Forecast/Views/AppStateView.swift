//
//  WeatherTodayView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct AppStateView: View {
    //MARK: Private properties
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var viewModel: WeatherTodayViewModel
    @State private var isAlertVisible = false
    @State private var title = ""
    @State private var message = ""
    
    var body: some View {
        VStack {
            let contentHeight: CGFloat = UIScreen.main.bounds.height > 667 ? 400 : 352

            VStack(alignment: .leading) {
                let Inter = Constants.Fonts.Inter.self
                let titleFont = Font.custom(Inter.bold, size: 64)
                let descriptionFontSize: CGFloat = 16

                Image("location")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: 43, height: 43)
                    .padding(.top, 7)
                Spacer()
                Text("Enable")
                    .font(titleFont)
                Text("location")
                    .font(titleFont)
                    .padding(.top, -52)
                Spacer()
                Text("Give us permission to see forecast for your current location.")
                    .font(Font.custom(Inter.medium, size: descriptionFontSize))
                    .lineSpacing(4)
                Spacer()
                Button("Enable location") {
                    openAlert()
                }
                .frame(width: 151, height: 40)
                .font(Font.custom(Inter.semiBold, size: descriptionFontSize))
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                .alert(title, isPresented: $isAlertVisible, actions: {
                    Button("Settings", action: {
                        // Opening settings for switching on location services.
                        // I'm testing on simulator which doesn't support location settings,
                        // therefore I'm opening settings instead of app location settings or location services settings.
                        openURL(URL(string: UIApplication.openSettingsURLString)!)
                    })
                    Button("Cancel", action: {})
                }, message: {
                    Text(message)
                })
            }
            .padding(.leading, 24)
            .frame(maxWidth: .infinity, maxHeight: contentHeight, alignment: .leading)
            .padding(.top, 100)
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

struct WeatherTodayView_Previews: PreviewProvider {
    static var previews: some View {
        AppStateView().environmentObject(WeatherTodayViewModel())
    }
}
