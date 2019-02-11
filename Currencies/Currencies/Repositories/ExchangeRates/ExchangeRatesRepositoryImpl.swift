//
//  ExchangeRatesRepositoryImpl.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Moya

final class ExchangeRatesRepositoryImpl: ExchangeRatesRepository {
    private let provider: MoyaProvider<ExchangeRatesRouter>

    init(provider: MoyaProvider<ExchangeRatesRouter>) {
        self.provider = provider
    }

    func getRatesFor(countryCode: String, completion: @escaping NetworkResult) {
        self.provider.request(.getRatesFor(countryCode: countryCode)) { result in
            completion(result)
        }
    }

    
}
