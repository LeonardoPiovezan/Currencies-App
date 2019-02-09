//
//  DefaultContainer+Repositories.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//
import Moya

extension DefaultContainer {
  func registerRepositories() {
    self.container.register(ExchangeRatesRepository.self) { _ in
        let provider = MoyaProvider<ExchangeRatesRouter>()
        return ExchangeRatesRepositoryImpl(provider: provider)
    }
  }
}
