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
        return UILabel
            .Builder()
            .withDescriptor(TitleLabelDescriptor())
            .build()
    }()

    lazy var tableView: UITableView = {
        return UITableView
            .Builder()
            .withSeparatorStyle(.none)
            .build()
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
        self.addSubview(self.tableView)
    }

    func setupConstraints() {
        self.label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        label.text = "Test Label"
        self.tableView.register(ExchangeRateCell.self, forCellReuseIdentifier: "rateCell")
    }
}
