//
//  ExchangeRatesService.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 09/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

protocol ExchangeRatesService {
    func getRatesFor(countryCode: String, completion: @escaping (Result<RateResult, NetworkError>) -> Void)
}
