//
//  ExchangeRatesRepository.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Moya
import Result

protocol ExchangeRatesRepository {
    typealias NetworkResult = (Result<Response, MoyaError>) -> Void

    func getRatesFor(countryCode: String, completion: @escaping NetworkResult)
}
