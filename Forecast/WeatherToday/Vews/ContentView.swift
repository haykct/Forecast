//
//  ContentView.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 30.07.23.
//

import SwiftUI

//extension Text {
//    func clippedAndScaledToFill(width: CGFloat, height: CGFloat, radius: CGFloat? = nil) -> some View {
//        self
//            .resizable()
//            .scaledToFill()
//            .frame(width: width, height: height)
//            .clipped()
//            .cornerRadius(radius ?? 0)
//    }
//}

struct ContentView: View {
    //MARK: Public properties
    @StateObject var viewModel = WeatherTodayViewModel()

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

                }
                .frame(width: 151, height: 40)
                .font(Font.custom(Inter.semiBold, size: descriptionFontSize))
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
            .padding(.leading, 24)
            .frame(maxWidth: .infinity, maxHeight: contentHeight, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 100)
        .onReceive(viewModel.$authorizationStatus, perform: { status in
            if status == .authorized { viewModel.requestData() }
        })
        .onAppear {
            viewModel.subscribeForAuthorizationStatusUpdate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
        ContentView()
            .previewDevice("iPhone 12")
        ContentView()
            .previewDevice("iPhone 11")
        ContentView()
            .previewDevice("iPhone SE (2nd generation)")
        ContentView()
            .previewDevice("iPhone SE (2nd generation)")
    }
}
