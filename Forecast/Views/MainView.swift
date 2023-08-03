//
//  MainView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct EmptyScreen: View {
    var body: some View {
        Text("Empty")
    }
}

struct MainView: View {
    var body: some View {
        let weatherTodayContentViewFactory = WeatherTodayContentViewFactory()
        
        TabView {
            weatherTodayContentViewFactory.makeView()
                .tabItem {
                    Image("TabBarTodayLight")
                        .renderingMode(.template)
                    Text("Today")
                }
            EmptyScreen()
                .tabItem {
                    Image("TabBarForecastLight")
                        .renderingMode(.template)
                    Text("Today")
                }
        }
        .accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice("iPhone 12 Pro Max")
        MainView()
            .previewDevice("iPhone 12")
        MainView()
            .previewDevice("iPhone 11")
        MainView()
            .previewDevice("iPhone SE (2nd generation)")
        MainView()
            .previewDevice("iPhone SE (1st generation)")
    }
}
