//
//  UILabelExtensions.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 02.11.24.
//

import UIKit

extension UILabel {
    func configureCustomLabel(text: String, textColor: UIColor, fontName: String, fontSize: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.preservesSuperviewLayoutMargins = true
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: fontName, size: fontSize)
        self.numberOfLines = 0
    }
}
