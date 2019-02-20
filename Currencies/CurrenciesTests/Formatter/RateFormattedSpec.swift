//
//  RateFormattedSpec.swift
//  CurrenciesTests
//
//  Created by Leonardo Piovezan on 19/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Quick
import Nimble

@testable import Currencies

class RateFormattedSpec: QuickSpec {
    override func spec() {
        describe("RateFormatted Behaviour") {

            context("") {
                it("") {

                    let rate = Rate(currencyCode: "EUR", rate: 1.0)

                    let currencyNameManager = CurrencyNameManagerImpl()
let rateFormatted = RateFormatted(rate: rate, currencyNameManager: currencyNameManager)

                    expect(rateFormatted.rateAmount) == 1
                    expect(rateFormatted.currencyName) == "Euro"
                    expect(rateFormatted.currencyCode) == "EUR"
                    expect(rateFormatted.finalAmount) == ""
                    expect(rateFormatted.countryImage) != nil
                }
            }
        }
    }
}
