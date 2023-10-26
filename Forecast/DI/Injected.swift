//
//  Injected.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 25.10.23.
//

import Foundation

@propertyWrapper struct Injected<Value> {
    var wrappedValue: Value

    init() {
        wrappedValue = DI.shared.container.resolve(Value.self)!
    }
}
