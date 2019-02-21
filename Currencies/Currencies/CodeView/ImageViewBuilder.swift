//
//  ImageViewBuilder.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

extension UIImageView {
    final class Builder {
        private var imageView: UIImageView!

        init() {
            self.imageView = UIImageView()
        }

        func withContentMode(_ mode: ContentMode) -> Builder {
            self.imageView.contentMode = mode
            return self
        }

        func build() -> UIImageView {
            return self.imageView
        }
    }
}
