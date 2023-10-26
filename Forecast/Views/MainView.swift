//
//  MainView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct MainView: View {
    //MARK: Public properties
    @StateObject var viewModel: MainViewModel

    //MARK: Private properties
    @State private var isContentViewAppeared = false
    
    var body: some View {
        VStack {
            switch viewModel.authorizationStatus {
            case .loading:
                ProgressView()
            case .authorized:
                TabView {
                    WeatherTodayContentView(viewModel: WeatherTodayViewModel())
                        .tabItem {
                            Image("TabBarTodayLight")
                                .renderingMode(.template)
                            Text("Today")
                        }
                    ForecastView()
                        .tabItem {
                            Image("TabBarForecastLight")
                                .renderingMode(.template)
                            Text("Forecast")
                        }
                        .edgesIgnoringSafeArea(.all)
                }
                .accentColor(.black)
            default:
                LocationView(viewModel: viewModel)
            }
        }
        .onAppear {
            if !isContentViewAppeared {
                isContentViewAppeared = true
                viewModel.subscribeForAuthorizationStatusUpdate()
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .previewDevice("iPhone 12 Pro Max")
//        MainView()
//            .previewDevice("iPhone 12")
//        MainView()
//            .previewDevice("iPhone 11")
//        MainView()
//            .previewDevice("iPhone SE (2nd generation)")
//        MainView()
//            .previewDevice("iPhone SE (1st generation)")
//    }
//}
