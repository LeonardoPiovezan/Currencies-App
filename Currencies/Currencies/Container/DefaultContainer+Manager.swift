//
//  DefaultContainer+Manager.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation

extension DefaultContainer {
    func registerManagers() {
        self.container.register(CurrencyNameManager.self) { _ in
            return CurrencyNameManagerImpl()
        }
    }
}
