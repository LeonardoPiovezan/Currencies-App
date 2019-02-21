//
//  TitleLabelDescriptor.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

struct TitleLabelDescriptor: LabelDescriptor {
    var font: UIFont

    var color: UIColor

    init() {
        self.font = UIFont(name: Constants.Font.helveticaNeue, size: 17)!
        self.color = .black
    }
}
