//
//  UIFont.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 07.11.23.
//

import UIKit

extension UIFont {
    static func custom(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)

        assert(font != nil, "Can't load font: \(name)")

        return font ?? UIFont.systemFont(ofSize: size)
    }
}
