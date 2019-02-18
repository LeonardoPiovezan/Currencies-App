//
//  ExchangeRatesRouter.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Moya

enum ExchangeRatesRouter {
    case getRatesFor(countryCode: String)
}

extension ExchangeRatesRouter: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Network.baseURL)!
    }

    var path: String {
        return "latest"
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getRatesFor(let countryCode):
            return Task.requestParameters(parameters: ["base": countryCode],
                                          encoding: URLEncoding.queryString)
        }

    }

    var headers: [String : String]? {
        return nil
    }
}
