//
//  DefaultContainer.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import Foundation
import Swinject

final class DefaultContainer {
  let container: Container

  init() {
    self.container = Container()
    self.registerServices()
    self.registerRepositories()
    self.registerManagers()
    self.registerViews()
  }
}
