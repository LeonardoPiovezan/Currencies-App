//
//  CountryNameManager.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

protocol CurrencyNameManager {
    func getNameFor(currencyCode: String) -> String
}
