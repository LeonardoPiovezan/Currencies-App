//
//  CountryFlagsManager.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 19/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//
import UIKit

protocol CountryFlagsManager {
    func getImageFor(countryCode: String) -> UIImage
}
