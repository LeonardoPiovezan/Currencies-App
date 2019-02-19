//
//  RateFormatted.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import FlagKit

class RateFormatted {
    var currencyCode: String!
    var currencyName: String!
    var countryImage: UIImage?

    var rateAmount: Double!

    var finalAmount: String! = ""

    private var rate: Rate
    private let currencyNameManager: CurrencyNameManager

    init(rate: Rate,
         currencyNameManager: CurrencyNameManager) {
        self.rate = rate
        self.currencyNameManager = currencyNameManager
        self.formatFields()
    }

    private func formatFields() {
        self.setCurrencyCode()
        self.setCurrencyName()
        self.setCountryImage()
        self.setRateAmount()
    }

    private func setCurrencyCode() {
        self.currencyCode = self.rate.currencyCode
    }

    private func setCurrencyName() {
        self.currencyName = self.currencyNameManager.getNameFor(currencyCode: rate.currencyCode)
    }

    private func setCountryImage() {
        let countryCode = self.currencyNameManager.getCountryNameFor(currencyCode: currencyCode)
        let flag = Flag(countryCode: countryCode)
        self.countryImage = flag?.originalImage
    }

    private func setRateAmount() {
        self.rateAmount = self.rate.rate
    }

    func updateWith(currentAmount: Double) -> RateFormatted {
        self.finalAmount = String(format: "%.2f", self.rateAmount*currentAmount) 
        return self
    }
}
