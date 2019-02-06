//
//  DefaultContainer+Views.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

extension DefaultContainer {
    func registerViews() {
        self.container.register(ExchangeRatesView.self) { _ in
            ExchangeRatesView()
        }
    }
}
