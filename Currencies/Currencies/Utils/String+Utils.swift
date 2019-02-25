//
//  String+Utils.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 19/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
}

extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."

        if formatter.number(from: self) != nil {
            let splitString = self.components(separatedBy: decimalSeparator)
            let digits = splitString.count == 2 ? splitString.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
}
