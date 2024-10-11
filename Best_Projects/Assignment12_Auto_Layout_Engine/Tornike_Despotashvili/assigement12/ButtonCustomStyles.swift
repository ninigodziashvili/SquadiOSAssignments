//
//  ButtonCustomStyles.swift
//  assigement12
//
//  Created by Despo on 10.10.24.
//

import UIKit

extension UIButton {
    func borderedButton(isDarkMode: Bool) {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.11, brightness: 0.22, alpha: 1).cgColor : UIColor(hue: 0, saturation: 0, brightness: 0.91, alpha: 1).cgColor
    }
    
    func filledButton(isDarkMode: Bool) {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = isDarkMode ?  UIColor(hue: 220/360, saturation: 0.11, brightness: 0.22, alpha: 1).cgColor : UIColor(hue: 0, saturation: 0, brightness: 0.91, alpha: 1).cgColor
        self.layer.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.11, brightness: 0.22, alpha: 1).cgColor
        :  UIColor(hue: 0, saturation: 0, brightness: 0.91, alpha: 1).cgColor
    }
}
