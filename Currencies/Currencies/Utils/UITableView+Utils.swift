//
//  UITableView+Utils.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 18/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

extension UITableView {
    func scrollToTop() {
        if self.numberOfRows(inSection: 0) > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
