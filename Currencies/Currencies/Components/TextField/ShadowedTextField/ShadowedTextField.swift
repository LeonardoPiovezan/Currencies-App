//
//  ShadowedTextField.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 18/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

class ShadowedTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        self.configureShadow()
    }

    private func configureShadow() {
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = UIColor(red: 130/255, green: 146/255, blue: 158/255, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shouldRasterize = false
        self.clipsToBounds = false
    }
}
