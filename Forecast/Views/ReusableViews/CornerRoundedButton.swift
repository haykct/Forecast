//
//  AppButton.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct CornerRoundedButton: View {
    //MARK: Private properties
    private let callback: () -> Void
    private let title: String

    //MARK: Initializers
    init(_ title: String, _ callback: @escaping () -> Void) {
        self.title = title
        self.callback = callback
    }

    var body: some View {
        Button(title) {
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
        CornerRoundedButton("", {})
    }
}
