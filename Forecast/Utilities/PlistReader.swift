//
//  PlistReader.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 02.08.23.
//

import Foundation

struct PlistReader {
    static func getValue(for key: String, name: String = "Info") throws -> Any? {
        guard let infoPlistPath = Bundle.main.url(forResource: name, withExtension: "plist") else {
            return nil
        }

        let data = try Data(contentsOf: infoPlistPath)

        guard let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return nil
        }

        return dict[key]
    }
}
