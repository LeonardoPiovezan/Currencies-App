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

    var amount: String = "" {
        didSet{
            self.view.amountTextField.text = amount
        }
    }

    var currencyCode: String = "" {
        didSet {
            self.view.currencyCodeLabel.text = currencyCode
        }
    }

    var currencyName: String = ""{
        didSet {
            self.view.currencyNameLabel.text = currencyName
        }
    }

    var countryImage: UIImage? {
        didSet {
            self.view.countryImageView.image = countryImage
        }
    }
    
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
        self.currencyCode = self.rateFormatted.currencyCode
        self.currencyName = self.rateFormatted.currencyName
        self.countryImage = self.rateFormatted.countryImage
        self.amount = String(self.rateFormatted.finalAmount)
    }

    func updateValue(value: Double) {
        self.amount = "\(value*rateFormatted.rateAmount)"
    }
}

extension ExchangeRateCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.view)
    }

    func setupConstraints() {
        self.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
    }
}
