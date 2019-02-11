//
//  ExchangeRateCell.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

final class ExchangeRateCell: UITableViewCell {

    lazy var countryImageView: UIImageView = {
        return UIImageView.Builder()
            .withContentMode(.scaleAspectFit)
            .build()
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


    lazy var amountTextField: UITextField = {
        return UITextField(frame: CGRect.zero)
    }()

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


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension ExchangeRateCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.countryImageView)
        self.addSubview(self.currencyCodeLabel)
        self.addSubview(self.currencyNameLabel)
        self.addSubview(self.amountTextField)
    }

    func setupConstraints() {
        self.countryImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }

        self.currencyCodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.countryImageView.snp.trailing)
            make.top.equalToSuperview().offset(8)
        }

        self.currencyNameLabel.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.leading.equalTo(self.currencyCodeLabel.snp.leading)
            make.top.equalTo(self.currencyCodeLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalTo(self.amountTextField)
        }

        self.amountTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(self.countryImageView.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
    }

    func setupAdditionalConfiguration() {
        self.currencyNameLabel.text = "name"
        self.currencyCodeLabel.text = "Code"
        self.selectionStyle = .none
    }
}
