//
//  CountryFlagsManagerImpl.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 19/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//
import FlagKit

class CountryFlagsManagerImpl: CountryFlagsManager {
    func getImageFor(countryCode: String) -> UIImage {
        let flag = Flag(countryCode: countryCode)
        return flag?.originalImage ?? UIImage(named: "flagPlaceholder")!
    }
}
