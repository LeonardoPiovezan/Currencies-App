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

    private let rate: Rate
    private let currencyNameManager: CurrencyNameManager

    init(rate: Rate,
         currencyNameManager: CurrencyNameManager) {
        self.rate = rate
        self.currencyNameManager = currencyNameManager
        self.formatFields()
    }

    private func formatFields() {
        let currencyCode = self.rate.currencyCode
        self.currencyCode = currencyCode
        self.currencyName = self.currencyNameManager.getNameFor(currencyCode: rate.currencyCode)

        let countryCode = self.currencyNameManager.getCountryNameFor(currencyCode: currencyCode)
        let flag = Flag(countryCode: countryCode)
        self.countryImage = flag?.originalImage
    }
}
