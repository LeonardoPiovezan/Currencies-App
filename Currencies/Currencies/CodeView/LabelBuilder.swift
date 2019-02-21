//
//  LabelBuilder.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 09/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

extension UILabel {

    class Builder {
        private var label: UILabel!
        init() {
            self.label = UILabel(frame: CGRect.zero)
        }

        func withNumberOfLines(_ lines: Int) -> Builder {
            self.label.numberOfLines = lines
            return self
        }

        func withFont(_ font: UIFont?) -> Builder {
            self.label.font = font
            return self
        }

        func withTextColor(_ color: UIColor) -> Builder {
            self.label.textColor = color
            return self
        }

        func withAlignment(_ alignment: NSTextAlignment) -> Builder {
            self.label.textAlignment = alignment
            return self
        }

        func withDescriptor(_ descriptor: LabelDescriptor) -> Builder {
            self.label = UILabel(descriptor: descriptor)
            return self
        }

        func build() -> UILabel {
            return self.label
        }
    }
}
