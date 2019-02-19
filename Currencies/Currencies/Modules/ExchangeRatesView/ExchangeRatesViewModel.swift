//
//  ExchangeRatesViewModel.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Moya

final class ExchangeRatesViewModel {

    private let exchangeRateService: ExchangeRatesService
    var didReceiveRates: ((Bool) -> Void)?
    var failedToReceiveRates: ((Error) -> Void)?

    private (set) var rateResult: RateResult?

    private (set) var rates: [Rate] = []

    private (set) var baseRate: Rate!

    private var previousCode = ""

    init(exchangeRateService: ExchangeRatesService) {
        self.exchangeRateService = exchangeRateService
    }

    func updateRatesFor(countryCode: String) {
        self.exchangeRateService.getRatesFor(countryCode: countryCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rateResult):
                self.rateResult = rateResult
                self.rates = rateResult.getRateList().sorted(by: { $1.currencyCode > $0.currencyCode })
                self.baseRate = Rate(currencyCode: rateResult.base, rate: 1.0)
                self.didReceiveRates?(self.previousCode == rateResult.base)
                self.previousCode = rateResult.base
            case .failure(let error):
                print(error)
                self.failedToReceiveRates?(error)
            }
        }
    }

}
