//
//  LabelExtension.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

import UIKit

extension UILabel {
    func configureLabel(text: String, font: UIFont, textColor: UIColor, alignment: NSTextAlignment, numberOfLines: Int = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
}
