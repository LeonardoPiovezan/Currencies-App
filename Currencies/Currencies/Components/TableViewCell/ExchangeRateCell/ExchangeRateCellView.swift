//
//  ExchangeRateCellView.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 18/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

final class ExchangeRateCellView: UIView {
    lazy var countryImageView: UIImageView = {
        return UIImageView.Builder()
            .withContentMode(.scaleAspectFit)
            .build()
    }()

    private var labelswrapperView: UIView = {
        return UIView()
    }()

    lazy var currencyCodeLabel: UILabel = {
        return UILabel.Builder()
            .withDescriptor(TitleLabelDescriptor())
            .build()
    }()

    lazy var currencyNameLabel: UILabel = {
        return UILabel.Builder()
            .withDescriptor(SubTitleLabelDescriptor())
            .build()
    }()

    lazy var amountTextField: ShadowedTextField = {
        let textField = ShadowedTextField(frame: CGRect.zero)
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        return textField
    }()

    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViewWith(rateFormatted: RateFormatted) {
        self.currencyCodeLabel.text = rateFormatted.currencyCode
        self.currencyNameLabel.text = rateFormatted.currencyName
        self.countryImageView.image = rateFormatted.countryImage
        self.amountTextField.text = rateFormatted.finalAmount
    }
}

extension ExchangeRateCellView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.countryImageView)
        self.addSubview(self.labelswrapperView)
        self.labelswrapperView.addSubview(self.currencyCodeLabel)
        self.labelswrapperView.addSubview(self.currencyNameLabel)
        self.addSubview(self.amountTextField)
    }

    func setupConstraints() {
        self.countryImageView.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.10)
            make.height.equalTo(self.countryImageView.snp.width)
        }

        self.labelswrapperView.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.leading.equalTo(self.countryImageView.snp.trailing).offset(8)
            make.centerY.equalTo(self.countryImageView.snp.centerY)
            make.trailing.equalTo(self.amountTextField.snp.trailing)
        }

        self.currencyCodeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
        }

        self.currencyNameLabel.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.leading.equalTo(self.currencyCodeLabel.snp.leading)
            make.top.equalTo(self.currencyCodeLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalTo(self.currencyCodeLabel.snp.trailing)
        }

        self.amountTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(self.countryImageView.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
    }

    func setupAdditionalConfiguration() {
        self.amountTextField.textAlignment = .right
        self.amountTextField.keyboardType = .decimalPad
    }
}
