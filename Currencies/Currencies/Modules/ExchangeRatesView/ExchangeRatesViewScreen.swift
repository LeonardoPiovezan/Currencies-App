//
//  ExchangeRatesViewScreen.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

final class ExchangeRatesViewScreen: UIView {
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
        self.addSubview(self.tableView)
    }

    func setupConstraints() {
        self.tableView.prepareForConstraints()
        self.tableView.pinEdgesToSuperview()
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        self.tableView.register(ExchangeRateCell.self, forCellReuseIdentifier: "rateCell")
        self.tableView.keyboardDismissMode = .onDrag
    }
}
