//
//  ReloadButton.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 01.08.23.
//

import SwiftUI

struct ReloadButton: View {
    //MARK: Private properties
    private let callback: () -> Void

    //MARK: Initializers
    init(_ callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    var body: some View {
        Button {
            callback()
        } label: {
            Image("reload")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
        .background(.white.opacity(0.3))
        .cornerRadius(24)
    }
}

struct ReloadButton_Previews: PreviewProvider {
    static var previews: some View {
        ReloadButton({})
    }
}
