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
    init () {}
    
    init(ratesResult: Result<RateResult, NetworkError>) {
        self.ratesResult = ratesResult
    }
    func getRatesFor(countryCode: String, completion: @escaping (Result<RateResult, NetworkError>) -> Void) {
        guard let result = ratesResult else {
             let result = Result<RateResult, NetworkError>.success(RateResult(base: countryCode, date: "10-02-2019", rates: ["EUR": 1.0, "BRL": 4.0, "USD": 1.5]))
            completion(result)
            return
        }
        completion(result)
    }


}
