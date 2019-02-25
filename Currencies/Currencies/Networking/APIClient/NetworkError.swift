//
//  NetworkError.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 09/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
