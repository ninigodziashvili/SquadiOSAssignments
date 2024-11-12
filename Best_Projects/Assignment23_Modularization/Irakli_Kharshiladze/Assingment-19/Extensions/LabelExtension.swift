//
//  ImageViewExtension.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

import Foundation
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
