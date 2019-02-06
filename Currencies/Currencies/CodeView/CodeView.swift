//
//  CodeView.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

protocol CodeView {
  func buildViewHierarchy()
  func setupConstraints()
  func setupAdditionalConfiguration()
  func setupView()
}

extension CodeView {
  func setupView() {
    buildViewHierarchy()
    setupConstraints()
    setupAdditionalConfiguration()
  }
}
