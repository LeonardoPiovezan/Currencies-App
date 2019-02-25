//
//  ExchangeRatesViewModel.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

final class ExchangeRatesViewModel {

    private let exchangeRateService: ExchangeRatesService
    private let currencyNameManager: CurrencyNameManager
    private let countryFlagsManager: CountryFlagsManager

    var didReceiveRates: ((Bool) -> Void)?
    var failedToReceiveRates: ((Error) -> Void)?

    private (set) var rates: [Rate] = []
    private (set) var ratesFormatted: [RateFormatted] = []
    private (set) var baseRate: Rate!

    private var previousCode = ""

    private var rateResult: RateResult!

    init(exchangeRateService: ExchangeRatesService,
         currencyNameManager: CurrencyNameManager,
         countryFlagsManager: CountryFlagsManager) {
        self.exchangeRateService = exchangeRateService
        self.currencyNameManager = currencyNameManager
        self.countryFlagsManager = countryFlagsManager
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

    func shouldChangeAmountTextField(amountString: String) -> Bool {
        let isNotLeftZero = amountString != "0"
        let isValidDouble = amountString.isValidDouble(maxDecimalPlaces: 4)
        let isEmpty = amountString.isEmpty
        return ((isValidDouble || isEmpty) && isNotLeftZero)
    }

    func getUpdatedRatesFormattedFor(currentAmount: Double) -> [RateFormatted] {
        return self.ratesFormatted.map { $0.updateWith(currentAmount: currentAmount) }
    }

    private func updateViewModelParameters() {
        self.updateRates()
        self.updateRatesFormatted()
        self.updateBaseRate()
        self.sendCompletionForSuccess()
        self.updatePreviousCode()
    }

    private func updateRates() {
        self.rates = rateResult.getRateList().sorted(by: { $1.currencyCode > $0.currencyCode })
    }

    private func updateRatesFormatted() {
        self.ratesFormatted = self.rates.map { RateFormatted(rate: $0,
                                                              currencyNameManager: self.currencyNameManager,
                                                              countryFlagsManager: self.countryFlagsManager)}
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
