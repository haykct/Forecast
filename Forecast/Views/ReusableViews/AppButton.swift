//
//  AppButton.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct AppButton: View {
    //MARK: Private properties
    private let callback: () -> Void

    //MARK: Initializers
    init(_ callback: @escaping () -> Void) {
        self.callback = callback
    }

    var body: some View {
        Button("Enable location") {
            callback()
        }
        .frame(width: 151, height: 40)
        .font(Font.custom(Constants.Fonts.Inter.semiBold, size: 16))
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton({})
    }
}
