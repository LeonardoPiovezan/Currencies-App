//
//  StringSpec.swift
//  CurrenciesTests
//
//  Created by Leonardo Piovezan on 19/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Quick
import Nimble

@testable import Currencies
class StringSpec: QuickSpec {
    override func spec() {
        describe("To Double Function Behaviour") {

            it("Check Value When It Is An Int") {
                let string = "3"
                let subject = string.toDouble()
                expect(subject) == 3
            }

            it("Check Value When It Is A Decimal") {
                let string = "3.57"
                let subject = string.toDouble()
                expect(subject) == 3.57
            }

            it("Check Value When It Is Not A Number") {
                let string = "asa"
                let subject = string.toDouble()
                expect(subject) == 0
            }

            it("Check When Value Is Mixed Numbers and Letters") {
                let string = "1s3f45f"
                let subject = string.toDouble()
                expect(subject) == 0
            }
        }
    }
}
