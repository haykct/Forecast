//
//  ViewFactory.swift
//  Forecast
//
//  Created by Hayk Hayrapetyan on 31.07.23.
//

import SwiftUI

protocol ViewFactory {
    associatedtype Scene: View
    
    func makeView() -> Scene
}

protocol ViewControllerFactory {
    func makeViewController() -> UIViewController
}
