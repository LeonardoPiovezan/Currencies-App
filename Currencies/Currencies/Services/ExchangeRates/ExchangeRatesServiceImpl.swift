//
//  ExchangeRatesServiceImpl.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 09/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
final class ExchangeRatesServiceImpl: ExchangeRatesService {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }
    func getRatesFor(countryCode: String, completion: @escaping (Result<RateResult, NetworkError>) -> Void) {
        self.client.fetch(with: ExchangeRatesRouter.getRatesFor(countryCode: countryCode).request,
                   decode: { json -> RateResult in
                    return json as! RateResult
        }, completion: completion)
    }
}
