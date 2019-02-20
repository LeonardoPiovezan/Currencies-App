//
//  DefaultContainer+Views.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

extension DefaultContainer {
    func registerViews() {
        self.container.register(ExchangeRatesView.self) { resolver in
            let service = resolver.resolve(ExchangeRatesService.self)!
            let currencyNameManager = resolver.resolve(CurrencyNameManager.self)!
            let countryFlagsManager = resolver.resolve(CountryFlagsManager.self)!
            return ExchangeRatesView(exchangeRatesService: service, currencyNameManager: currencyNameManager,
                                     countryFlagsManager: countryFlagsManager)
        }
    }
}
