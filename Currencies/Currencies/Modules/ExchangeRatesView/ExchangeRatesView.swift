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

  private var ratesFormatted: [RateFormatted]!

  @objc dynamic private var firstRate: Rate?
  @objc dynamic var currentValue: Double = 0.0

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
        self.screen.tableView.delegate = self
        self.screen.tableView.dataSource = self
//      self.setUpTimer()
    }

    func setupViewModel() {
        self.viewModel = ExchangeRatesViewModel(exchangeRateService: self.exchangeRatesService)
        self.viewModel.didReceiveRates = { [weak self] in
          self?.firstRate = self?.viewModel.baseRate

          self?.ratesFormatted = self?.viewModel.rates.map { RateFormatted(rate: $0, currencyNameManager: self!.currencyNameManager)}
          self?.updateTableView()
        }

        self.viewModel.failedToReceiveRates = { error in
            print(error)
        }

        self.viewModel.updateRatesFor(countryCode: "EUR")
    }

    func updateTableView() {
        self.screen.tableView.reloadData()
    }

  func setUpTimer() {
    let oi = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [weak self] timer in

      self?.viewModel.updateRatesFor(countryCode: self?.firstRate?.currencyCode ?? "EUR")
    }
    oi.fire()
  }
}
extension ExchangeRatesView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    if indexPath.row == 0 {
      return
    }

    UIView.animate(withDuration: 0.5, animations: {
      self.screen.tableView.dataSource?.tableView?(self.screen.tableView, moveRowAt: indexPath, to: IndexPath(row: 0, section: 0))

    }) { (finished) in
      let rate = self.viewModel.rates[indexPath.row - 1]

      self.viewModel.updateRatesFor(countryCode: rate.currencyCode)
    }
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    UIView.animate(withDuration: 0.5, animations: {
      self.screen.tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }) { finished in
      self.firstRate = self.viewModel.rates[sourceIndexPath.row - 1]
      self.updateTableView()
    }
  }
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}

extension ExchangeRatesView: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if self.viewModel.rates.count > 0 {
        if section == 0 {
          return 1
        }
//        return (self.viewModel.rates.count)
        return self.ratesFormatted.count
      }
      return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell") as! ExchangeRateCell
      if indexPath.section == 0 {
          cell.bindTo(rateFormatted: RateFormatted(rate: self.firstRate!,
                                                   currencyNameManager: self.currencyNameManager))

          cell.amountTextField.delegate = self
          cell.stopListening()
          return cell
      }

//        let rate = self.viewModel.rates[indexPath.row]

      let rate = self.ratesFormatted[indexPath.row]
//        cell.bindTo(rateFormatted: RateFormatted(rate: rate,
//                                                 currencyNameManager: self.currencyNameManager))
      cell.bindTo(rateFormatted: rate)
        return cell
    }

}

extension ExchangeRatesView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

      let number = String(textField.text! + string)
      NotificationCenter.default.post(name: Notification.Name.CurrentAmount, object: self, userInfo: ["currentAmount": Double(number) ?? 0.0])
      ExchangeRateCell.currentAmount = Double(number) ?? 0.0
      return true
    }
}

extension UITableView {
  func scrollToTop() {
    if self.numberOfRows(inSection: 0) > 0 {
      let indexPath = IndexPath(row: 0, section: 0)
      self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
  }
}
