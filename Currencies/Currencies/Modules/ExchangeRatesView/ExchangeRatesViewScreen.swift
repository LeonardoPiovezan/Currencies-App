//
//  ExchangeRatesViewScreen.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import SnapKit

final class ExchangeRatesViewScreen: UIView {

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Test Label"
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExchangeRatesViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.label)
    }

    func setupConstraints() {
        self.label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
}
