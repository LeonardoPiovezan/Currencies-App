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


    lazy var amountTextField: UITextField = {
        return UITextField(frame: CGRect.zero)
    }()

    private var rate: Rate!

  @objc private var rateFormatted: RateFormatted! {
    didSet {
      self.amountTextField.text = String(ExchangeRateCell.currentAmount*rateFormatted.rateAmount)
    }
  }

  @objc static var currentAmount: Double = 0.0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
      addObserver(self, forKeyPath: #keyPath(rateFormatted.currencyName), options: [.old, .new], context: nil)
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

  func bindTo(rateFormatted: RateFormatted) {
        self.rateFormatted = rateFormatted
        self.updateCellContent()

     NotificationCenter.default.addObserver(self, selector: #selector(didChangeAmount(notification:)), name: NSNotification.Name.CurrentAmount, object: nil)
    }

  func stopListening() {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.CurrentAmount, object: nil)
  }

    func updateCellContent() {
        self.currencyCodeLabel.text = self.rateFormatted.currencyCode
        self.currencyNameLabel.text = self.rateFormatted.currencyName
        self.countryImageView.image = self.rateFormatted.countryImage
    }

}

extension ExchangeRateCell: CodeView {
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
            make.width.equalToSuperview().multipliedBy(0.30)
        }
    }

    func setupAdditionalConfiguration() {
        self.selectionStyle = .none

        amountTextField.borderStyle = .roundedRect
        amountTextField.layer.masksToBounds = false
        amountTextField.layer.shadowRadius = 1.0
        amountTextField.layer.shadowColor = UIColor.black.cgColor
        amountTextField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        amountTextField.layer.shadowOpacity = 1.0
    }
}

extension ExchangeRateCell {

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

    let amount = object as! Double
    self.amountTextField.text = String(amount*rateFormatted.rateAmount)
  }

  @objc func didChangeAmount(notification: Notification) {
    let currentAmount = notification.userInfo!["currentAmount"] as! Double
    self.amountTextField.text = "\(currentAmount*rateFormatted.rateAmount)"
    ExchangeRateCell.currentAmount = currentAmount

  }
}

extension Notification.Name {
  static let CurrentAmount = Notification.Name(rawValue: "currentAmount")
}
