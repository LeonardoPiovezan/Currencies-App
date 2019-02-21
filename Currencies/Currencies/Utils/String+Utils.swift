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
