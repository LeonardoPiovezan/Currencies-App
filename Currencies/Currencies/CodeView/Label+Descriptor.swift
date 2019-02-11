//
//  Label+Descriptor.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(descriptor: LabelDescriptor) {
        self.init(frame: CGRect.zero)
        self.setUp(with: descriptor)
    }

    func setUp(with descriptor: LabelDescriptor) {
        self.textColor = descriptor.color
        self.font = descriptor.font
    }
}
