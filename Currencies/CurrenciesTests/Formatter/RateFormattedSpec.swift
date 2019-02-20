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
        var rate: Rate!
        var rateFormatted: RateFormatted!
        describe("RateFormatted Behaviour") {
            context("Rate Has All Fields") {
                beforeEach {
                    rate = Rate(currencyCode: "EUR", rate: 2.0)
                    let currencyNameManager = CurrencyNameManagerImpl()
                    rateFormatted = RateFormatted(rate: rate,
                                                      currencyNameManager: currencyNameManager,
                                                      countryFlagsManager: CountryFlagsManagerImpl())
                }

                it("Check If Fields Are Correctly Transformed") {
                    expect(rateFormatted.rateAmount) == 2
                    expect(rateFormatted.currencyName) == "Euro"
                    expect(rateFormatted.currencyCode) == "EUR"
                    expect(rateFormatted.finalAmount) == ""
                }

                it("Check Updating With Typed Amount") {
                    let newRateFormatted = rateFormatted.updateWith(currentAmount: 2.0)
                    expect(newRateFormatted.rateAmount) == 2
                    expect(newRateFormatted.currencyName) == "Euro"
                    expect(newRateFormatted.currencyCode) == "EUR"
                    expect(newRateFormatted.finalAmount) == "4.00"
                }
            }

            context("Check When Country Is Not Recognized") {
                it("Check If PlaceholderImage Is Set") {
                    rate = Rate(currencyCode: "AAAA", rate: 2.0)
                    let currencyNameManager = CurrencyNameManagerImpl()
                    rateFormatted = RateFormatted(rate: rate,
                                                  currencyNameManager: currencyNameManager,
                                                  countryFlagsManager: CountryFlagsManagerImpl())
                    expect(rateFormatted.countryImage) == UIImage(named: "flagPlaceholder")
                }
            }
        }
    }
}
