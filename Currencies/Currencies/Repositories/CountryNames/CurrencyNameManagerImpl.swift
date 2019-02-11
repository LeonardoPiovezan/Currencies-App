//
//  CountryNameManagerImpl.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

class CurrencyNameManagerImpl: CurrencyNameManager {
    func getNameFor(currencyCode: String) -> String {
        let name = Locale.current.localizedString(forCurrencyCode: currencyCode)
        return name ?? ""
    }
}
