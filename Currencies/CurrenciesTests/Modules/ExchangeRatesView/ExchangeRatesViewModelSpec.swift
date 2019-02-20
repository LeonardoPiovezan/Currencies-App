////
////  ExchangeRatesViewModelSpec.swift
////  CurrenciesTests
////
////  Created by Leonardo Piovezan on 10/02/19.
////  Copyright © 2019 Leonardo Piovezan. All rights reserved.
////

import Quick
import Nimble
import Result

@testable import Currencies
class ExchangeRatesViewModelSpec: QuickSpec {

    var subject: ExchangeRatesViewModel!
    var ratesService: ExchangeRatesService!
    var currencyNameManager = CurrencyNameManagerImpl()
    override func spec() {
        describe("Exchange Rates View Behaviour") {
            context("Received Rates From Service") {
                beforeEach {
                    let result = Result<RateResult, NetworkError>.success(RateResult(base: "EUR", date: "10-02-2019", rates: ["EUR": 1.0, "BRL": 4.0, "USD": 1.5]))

                    self.ratesService = MockExchangeRateService(ratesResult: result)
                    self.subject = ExchangeRatesViewModel(exchangeRateService: self.ratesService,
                                                          currencyNameManager: self.currencyNameManager)
                }

                it("Check If Sucess Rates Are Sorted") {
                    self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 0.0)
                    let result = self.subject.rates

                    let rates = [Rate(currencyCode: "BRL", rate: 4.0),
                                 Rate(currencyCode: "EUR", rate: 1.0),
                                 Rate(currencyCode: "USD", rate: 1.5)]
                    expect(result).to(equal(rates))
                }

                it("Check Base Currency") {
                    self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 0.0)
                    expect(self.subject.baseRate) == Rate(currencyCode: "EUR", rate: 1.0)
                }

                it("Check Updates When Amount Changes") {
                    self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 1.0)
                    let rates = self.subject.rates.map { RateFormatted(rate: $0,
                                                                       currencyNameManager: self.currencyNameManager,
                                                                       countryFlagsManager: CountryFlagsManagerImpl())}
                    let newRatesFormatted = self.subject.updateCurrentAmountFor(ratesFormatted: rates, currentAmount: 10)

                    let amounts = newRatesFormatted.map { $0.finalAmount }

                    expect(amounts) == ["40.00", "10.00", "15.00"]

                }



                context("Check Multiples Requests Call") {
                    beforeEach {
                        self.ratesService = MockExchangeRateService()
                        self.subject = ExchangeRatesViewModel(exchangeRateService: self.ratesService,
                                                              currencyNameManager: self.currencyNameManager)
                    }

                    it("Check If Keep Old Data Is True") {
                        self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 0.0)
                        self.subject.didReceiveRates = { keepData in
                            expect(keepData).to(beTrue())
                        }
                        self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 1.0)
                        self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 10)

                    }

                    it("Check If Keep Old Data Is False") {
                        self.subject.updateRatesFor(countryCode: "EUR", currentAmount: 0.0)
                        self.subject.didReceiveRates = { keepData in
                            expect(keepData).to(beFalse())
                        }
                        self.subject.updateRatesFor(countryCode: "BRL", currentAmount: 5.0)
                    }
                }

            }

            context("Check Condition For Error From Service") {
                beforeEach {
                    let result = Result<RateResult, NetworkError>.failure(NetworkError(message: "Failed to Download"))
                    self.ratesService = MockExchangeRateService(ratesResult: result)
                    self.subject = ExchangeRatesViewModel(exchangeRateService: self.ratesService,
                                                          currencyNameManager: CurrencyNameManagerImpl())
                }

                it("Check if error message is not nil") {
                    self.subject.failedToReceiveRates = { error in
                        let networkError = error as! NetworkError
                        expect(networkError.localizedDescription).to(equal("Failed to Download"))
                    }
                    self.subject.updateRatesFor(countryCode: "country",
                                                currentAmount: 0.0)
                }
            }
        }
    }
}
