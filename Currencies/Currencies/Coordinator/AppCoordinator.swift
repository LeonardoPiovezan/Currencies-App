//
//  AppCoordinator.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    private weak var window: UIWindow?
    private let container: DefaultContainer
    
    init(window: UIWindow,
         container: DefaultContainer) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let exchangeView = container.container.resolve(ExchangeRatesView.self)!
        self.window?.rootViewController = exchangeView 
    }
}
