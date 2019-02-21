//
//  SubTitleLabelDescriptor.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

struct SubTitleLabelDescriptor: LabelDescriptor {
    var font: UIFont
    var color: UIColor

    init() {
        self.font = UIFont(name: Constants.Font.helveticaNeueLight, size: 14)!
        self.color = .gray
    }
}

