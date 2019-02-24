//
//  ExchangeRateCell.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

final class ExchangeRateCell: UITableViewCell {
    lazy var view: ExchangeRateCellView = {
        return ExchangeRateCellView()
    }()

    private var rateFormatted: RateFormatted!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindTo(rateFormatted: RateFormatted) {
        self.rateFormatted = rateFormatted
        self.updateCellContent()
    }

    func updateCellContent() {
        self.view.configureViewWith(rateFormatted: self.rateFormatted)
    }
}

extension ExchangeRateCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.view)
    }

    func setupConstraints() {
        self.view.prepareForConstraints()
        self.view.pinEdgesToSuperview()
    }

    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
    }
}
