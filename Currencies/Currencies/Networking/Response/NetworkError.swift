//
//  NetworkError.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 09/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

class NetworkError: LocalizedError {

    private let message: String

    init(message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return self.message
    }
}
