//
//  Endpoint.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 23/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//
import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        let queryItems = parameters?.map({ parameter -> URLQueryItem in
            let (key, value) = parameter
            return URLQueryItem(name: key, value: value as? String)
        })
        components.queryItems = queryItems
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
