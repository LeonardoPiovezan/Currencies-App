//
//  ExchangeRatesView.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 05/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit
import Moya

final class ExchangeRatesView: UIViewController {
    private let exchangeRatesService: ExchangeRatesService
    private let currencyNameManager: CurrencyNameManager

    private var screen: ExchangeRatesViewScreen!

    private var viewModel: ExchangeRatesViewModel!

    private var ratesFormatted: [RateFormatted]! = []

    private var currentAmount: Double = 0
    private var firstRate: Rate?
    private var currentValue: Double = 0.0
    private var timer: Timer?

    init(exchangeRatesService: ExchangeRatesService,
         currencyNameManager: CurrencyNameManager) {
        self.exchangeRatesService = exchangeRatesService
        self.currencyNameManager = currencyNameManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.screen = ExchangeRatesViewScreen()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.requestRatesFor(currencyCode: "EUR")
        self.screen.tableView.delegate = self
        self.screen.tableView.dataSource = self
    }

    func setupViewModel() {
        self.viewModel = ExchangeRatesViewModel(exchangeRateService: self.exchangeRatesService,
                                                currencyNameManager: self.currencyNameManager)
        self.viewModel.didReceiveRates = { [weak self] shouldKeepData in

            self?.firstRate = self?.viewModel.baseRate

            self?.ratesFormatted = self?.viewModel.rates.map { RateFormatted(rate: $0, currencyNameManager: self!.currencyNameManager).updateWith(currentAmount: self!.currentAmount)}
            if shouldKeepData {
                self?.updateTableView()
            } else {
                self?.currentAmount = 0.0
                self?.screen.tableView.reloadData()
                self?.screen.tableView.scrollToTop()
            }
        }

        self.viewModel.failedToReceiveRates = { error in
            print(error)
        }
    }

    func updateTableView() {
        self.screen.tableView.indexPathsForVisibleRows?
            .filter { $0.row != 0 }
            .forEach { [weak self] index in
                let cell = self?.screen.tableView.cellForRow(at: index) as! ExchangeRateCell
                cell.bindTo(rateFormatted: self!.ratesFormatted[index.row])
        }
    }

    func requestRatesFor(currencyCode: String) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [weak self] timer in
            self?.viewModel.updateRatesFor(countryCode: currencyCode, currentAmount: self?.currentAmount ?? 0.00)
        }
        self.timer?.fire()
    }

    func setUpTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [weak self] timer in
            let countryCode = self?.firstRate?.currencyCode ?? "EUR"
            self?.viewModel.updateRatesFor(countryCode: countryCode, currentAmount: self?.currentAmount ?? 0.00)
        }
    }
}

extension ExchangeRatesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! ExchangeRateCell
            cell.view.amountTextField.becomeFirstResponder()
            return
        }

        self.timer?.invalidate()
        UIView.animate(withDuration: 2, animations: {
            self.screen.tableView.beginUpdates()
            self.screen.tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            self.screen.tableView.endUpdates()

        }) { (finished) in
            let rate = self.ratesFormatted[indexPath.row]
            self.requestRatesFor(currencyCode: rate.currencyCode)
        }
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ExchangeRatesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ratesFormatted.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell") as! ExchangeRateCell
        if indexPath.row == 0 {
            cell.bindTo(rateFormatted: RateFormatted(rate: self.firstRate!,
                                                     currencyNameManager: self.currencyNameManager))
            cell.view.amountTextField.text = String(self.currentAmount)
            cell.view.amountTextField.addTarget(self, action: #selector(editingChange(_:)), for: .editingChanged)
            return cell
        }

        let rate = self.ratesFormatted[indexPath.row]
        cell.bindTo(rateFormatted: rate)
        return cell
    }

  @objc func editingChange(_ textField: UITextField) {
    let numberString = textField.text ?? ""

    self.currentAmount = numberString.toDouble()
    self.ratesFormatted = self.ratesFormatted.compactMap { $0.updateWith(currentAmount: self.currentAmount ) }

    self.updateTableView()
  }
}
