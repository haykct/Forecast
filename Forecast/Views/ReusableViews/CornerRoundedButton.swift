//
//  AppButton.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

struct CornerRoundedButton: View {
    // MARK: Enums
    enum Style {
        case dark
        case light
    }

    // MARK: Private properties
    private let titleKey: String
    private let style: Style
    private let callback: () -> Void

    // MARK: Initializers
    init(_ titleKey: String, style: Style = .dark, _ callback: @escaping () -> Void) {
        self.titleKey = titleKey
        self.style = style
        self.callback = callback
    }

    var body: some View {
        Button(titleKey.localized) {
            callback()
        }
        .frame(height: 40)
        .padding([.leading, .trailing], 16)
        .font(Font.custom(Fonts.Inter.semiBold, size: 16))
        .background(style == .light ? .white.opacity(0.3) : .black)
        .foregroundColor(style == .light ? .black : .white)
        .cornerRadius(20)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        CornerRoundedButton("", {})
    }
}
