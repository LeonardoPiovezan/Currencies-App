//
//  ExchangeRatesRouter.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

enum ExchangeRatesRouter {
    case getRatesFor(countryCode: String)
}

extension ExchangeRatesRouter: Endpoint {
    var parameters: [String : Any]? {
        switch self {
        case .getRatesFor(let currencyCode):
            return ["base": currencyCode]
        }
    }

    var path: String {
        return "/latest"
    }

    var base: String {
        return Constants.Network.baseURL
    }
}
