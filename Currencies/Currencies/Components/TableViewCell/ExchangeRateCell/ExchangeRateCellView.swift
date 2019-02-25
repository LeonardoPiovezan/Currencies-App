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
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var labelswrapperView: UIView = {
        return UIView()
    }()

    lazy var currencyCodeLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        label.font = UIFont(name: Constants.Font.helveticaNeue, size: 17)!
        label.textColor = .black
        return label
    }()

    lazy var currencyNameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        label.font = UIFont(name: Constants.Font.helveticaNeueLight, size: 14)!
        label.textColor = .gray
        return label
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
        self.setupCountryImageViewConstraints()
        self.setupLabelsWrapperViewConstraints()
        self.setupCurrencyCodeLabelConstraints()
        self.setupCurrencyNameLabelConstraints()
        self.setupAmountTextFieldConstraints()
    }

    private func setupCountryImageViewConstraints() {
        self.countryImageView.prepareForConstraints()
        self.countryImageView.pinTop(8)
        self.countryImageView.pinLeft(8)
        self.countryImageView.pinBottom(8)

        self.countryImageView.constraintWidth(toAnchor: self.widthAnchor, multiplier: 0.1)
        self.countryImageView.squareViewConstraint()
    }

    private func setupLabelsWrapperViewConstraints() {
        self.labelswrapperView.prepareForConstraints()
        self.labelswrapperView.pinLeftInRelationTo(heightAnchor: self.countryImageView.rightAnchor, constant: 8)

        self.labelswrapperView.centerVertically(inRelationTo: self.countryImageView)

        self.labelswrapperView.pinRightInRelationTo(heightAnchor: self.amountTextField.leftAnchor, constant: 0)
    }

    private func setupCurrencyCodeLabelConstraints() {
        self.currencyCodeLabel.prepareForConstraints()
        self.currencyCodeLabel.pinLeft()
        self.currencyCodeLabel.pinTop(8)
        self.currencyCodeLabel.pinRight()
    }

    private func setupCurrencyNameLabelConstraints() {
        self.currencyNameLabel.prepareForConstraints()
        self.currencyNameLabel.pinLeft()
        self.currencyNameLabel.pinTop(0, target: self.currencyCodeLabel)
        self.currencyNameLabel.pinRight()
        self.currencyNameLabel.pinBottom(8)
    }

    private func setupAmountTextFieldConstraints() {
        self.amountTextField.prepareForConstraints()
        self.amountTextField.pinRight(8)
        self.amountTextField.centerVertically(inRelationTo: self.countryImageView)
        self.amountTextField.constraintWidth(toAnchor: self.widthAnchor, multiplier: 0.45)
    }

    func setupAdditionalConfiguration() {
        self.amountTextField.textAlignment = .right
        self.amountTextField.keyboardType = .decimalPad
    }
}
