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
        let value = self.replacingOccurrences(of: ",", with: ".")
        return Double(value) ?? 0.0
    }
}

extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."

        var value = self
        if decimalSeparator == "," {
            value = self.replacingOccurrences(of: ".", with: ",")
        } else if decimalSeparator == "." {
            value = self.replacingOccurrences(of: ",", with: ".")
        }

        if formatter.number(from: value) != nil {
            let splitString = value.components(separatedBy: decimalSeparator)

            let digits = splitString.count == 2 ? splitString.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
}
