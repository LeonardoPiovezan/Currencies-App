//
//  RateResult.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 06/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

struct RateResult: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}

struct Rate {
    let countryCode: String
    let rate: Double
}
