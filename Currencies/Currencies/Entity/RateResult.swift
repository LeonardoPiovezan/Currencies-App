//
//  RateResult.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 06/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

struct RateResult: Codable, Equatable {
    let base: String
    let date: String
    let rates: [String: Double]

    func getRateList() -> [Rate] {
        return rates.map{ Rate(countryCode: $0, rate: $1) }
    }
}

struct Rate: Equatable {
    let countryCode: String
    let rate: Double
}
