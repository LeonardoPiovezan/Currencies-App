//
//  DefaultContainer+APIClient.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

extension DefaultContainer {
  func registerAPIClient() {
    self.container.register(APIClient.self) { _ in
        APIClientImpl()
    }
  }
}
