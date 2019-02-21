//
//  TableViewBuilder.swift
//  Currencies
//
//  Created by Leonardo Piovezan on 10/02/19.
//  Copyright © 2019 Leonardo Piovezan. All rights reserved.
//

import UIKit

extension UITableView {
    final class Builder {
        private var tableView: UITableView!

        init() {
            self.tableView = UITableView(frame: CGRect.zero)
        }

        func withBackgroundColor(_ color: UIColor) -> Builder {
            self.tableView.backgroundColor = color
            return self
        }

        func withSeparatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Builder {
            self.tableView.separatorStyle = style
            return self
        }

        func build() -> UITableView {
            return self.tableView
        }
    }
}
