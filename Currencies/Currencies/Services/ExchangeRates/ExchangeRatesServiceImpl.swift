//
//  ExchangeRatesServiceImpl.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 09/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Result

final class ExchangeRatesServiceImpl: ExchangeRatesService {
    private let exchangeRatesRepository: ExchangeRatesRepository

    init(exchangeRatesRepository: ExchangeRatesRepository) {
        self.exchangeRatesRepository = exchangeRatesRepository
    }

    func getRatesFor(countryCode: String, completion: @escaping (Result<RateResult, NetworkError>) -> Void) {
        self.exchangeRatesRepository.getRatesFor(countryCode: countryCode) { result in
            switch result {
            case .success(let response):
                do {
                    let rateResult = try response.map(RateResult.self)
                  print(rateResult)
                    completion(Result.success(rateResult))
                } catch let error {
                    let networkError = NetworkError(message: error.localizedDescription)
                    completion(Result.failure(networkError))
                }
            case .failure(let error):
                let networkError = NetworkError(message: error.localizedDescription)
                completion(Result.failure(networkError))
            }
        }
    }
}
