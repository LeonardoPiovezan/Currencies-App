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
    }

    func setupViewModel() {
        self.viewModel = ExchangeRatesViewModel(exchangeRateService: self.exchangeRatesService)
        self.viewModel.didReceiveRates = { [weak self] in
            self?.updateTableView()
        }

        self.viewModel.failedToReceiveRates = { error in
            print(error)
        }

        self.viewModel.updateRatesFor(countryCode: "BRL")
    }

    func updateTableView() {
        self.screen.tableView.reloadData()
    }
}
extension ExchangeRatesView: UITableViewDelegate {

}

extension ExchangeRatesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell") as! ExchangeRateCell

        let rate = self.viewModel.rates[indexPath.row]

        cell.bindTo(rateFormatted: RateFormatted(rate: rate,
                                                 currencyNameManager: self.currencyNameManager))
//        cell.currencyCodeLabel.text = rate.countryCode
//        cell.currencyNameLabel.text = self.currencyNameManager.getNameFor(currencyCode: rate.countryCode)

        return cell
    }


}
