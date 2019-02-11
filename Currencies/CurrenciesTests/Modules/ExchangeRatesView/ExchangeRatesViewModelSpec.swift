//
//  ExchangeRatesViewModelSpec.swift
//  CurrenciesTests
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Quick
import Nimble
import Result

@testable import Currencies
class ExchangeRatesViewModelSpec: QuickSpec {

    var subject: ExchangeRatesViewModel!
    var ratesService: ExchangeRatesService!

    override func spec() {

        describe("Exchange Rates View Behaviour") {

            context("Received Rates From Service") {

                beforeEach {
                    let result = Result<RateResult, NetworkError>.success(RateResult(base: "EUR", date: "10-02-2019", rates: ["EUR": 1.0, "BRL": 4.0, "USD": 1.5]))
                    self.ratesService = MockExchangeRateService(ratesResult: result)
                    self.subject = ExchangeRatesViewModel(exchangeRateService: self.ratesService)
                }

                it("Check Condition When result is success with one Rate") {
                    self.subject.updateRatesFor(countryCode: "EUR")
                    let result = self.subject.rates

                    let countryCodes = [Rate(countryCode: "BRL", rate: 4.0),
                                        Rate(countryCode: "EUR", rate: 1.0),
                                        Rate(countryCode: "USD", rate: 1.5)]
                    expect(result).to(equal(countryCodes))

                }

            }

            context("Check Condition For Erro from Service") {
                beforeEach {
                    let result = Result<RateResult, NetworkError>.failure(NetworkError(message: "Failed to Download"))
                    self.ratesService = MockExchangeRateService(ratesResult: result)
                    self.subject = ExchangeRatesViewModel(exchangeRateService: self.ratesService)
                }

                it("Check if error message is not nil") {
                    self.subject.failedToReceiveRates = { error in
                        let networkError = error as! NetworkError
                    expect(networkError.localizedDescription).to(equal("Failed to Download"))
                    }
                    self.subject.updateRatesFor(countryCode: "country")
                }
            }
        }
    }
}
