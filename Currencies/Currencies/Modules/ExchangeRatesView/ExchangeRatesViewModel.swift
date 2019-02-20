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
    private let currencyNameManager: CurrencyNameManager
    var didReceiveRates: ((Bool) -> Void)?
    var failedToReceiveRates: ((Error) -> Void)?

    private (set) var rates: [Rate] = []
    private (set) var baseRate: Rate!

    private var previousCode = ""

    private var rateResult: RateResult!

    init(exchangeRateService: ExchangeRatesService,
         currencyNameManager: CurrencyNameManager) {
        self.exchangeRateService = exchangeRateService
        self.currencyNameManager = currencyNameManager
    }

    func updateRatesFor(countryCode: String, currentAmount: Double) {
        self.exchangeRateService.getRatesFor(countryCode: countryCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rateResult):
                self.rateResult = rateResult
                self.updateViewModelParameters()
            case .failure(let error):
                self.failedToReceiveRates?(error)
            }
        }
    }

    private func updateViewModelParameters() {
        self.updateRates()
        self.updateBaseRate()
        self.sendCompletionForSuccess()
        self.updatePreviousCode()
    }

    private func updateRates() {
        self.rates = rateResult.getRateList().sorted(by: { $1.currencyCode > $0.currencyCode })
    }

    private func updateBaseRate() {
        self.baseRate = Rate(currencyCode: rateResult.base, rate: 1.0)
    }

    private func sendCompletionForSuccess() {
        let keepData = self.previousCode == rateResult.base
        self.didReceiveRates?(keepData)
    }

    private func updatePreviousCode() {
        self.previousCode = rateResult.base
    }
}
