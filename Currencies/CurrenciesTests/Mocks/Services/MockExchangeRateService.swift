//
//  MockExchangeRateService.swift
//  CurrenciesTests
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Result

@testable import Currencies
final class MockExchangeRateService: ExchangeRatesService {

    private var ratesResult: Result<RateResult, NetworkError>!
    init(ratesResult: Result<RateResult, NetworkError>) {
        self.ratesResult = ratesResult
    }
    func getRatesFor(countryCode: String, completion: @escaping (Result<RateResult, NetworkError>) -> Void) {
        completion(ratesResult)
    }


}
