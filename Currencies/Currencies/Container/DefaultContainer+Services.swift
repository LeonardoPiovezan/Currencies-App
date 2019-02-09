//
//  DefaultContainer+Services.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

extension DefaultContainer {
    func registerServices() {
        self.container.register(ExchangeRatesService.self) { resolver in
            let repository: ExchangeRatesRepository = resolver.resolve(ExchangeRatesRepository.self)!
            return ExchangeRatesServiceImpl(exchangeRatesRepository: repository)
        }
    }
}
