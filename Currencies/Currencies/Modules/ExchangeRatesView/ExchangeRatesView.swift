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
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ExchangeRatesViewScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = MoyaProvider<ExchangeRatesRouter>()
        let test = ExchangeRatesRepositoryImpl(provider: provider)

        test.getRatesFor(countryCode: "EUR") { (result) in
            print(result)
        }

    }
}
