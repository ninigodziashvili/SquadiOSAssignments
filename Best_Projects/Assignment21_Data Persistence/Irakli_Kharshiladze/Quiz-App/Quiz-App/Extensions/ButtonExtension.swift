//
//  ButtonExtension.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 04.11.24.
//

import UIKit

extension UIButton {
    func configureButton(text: String, font: UIFont, titleColor: UIColor, tintColor: UIColor, image: String, backgroundColor: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.contentHorizontalAlignment = .leading
        self.tintColor = tintColor
        self.layer.cornerRadius = 12
        self.setImage(UIImage(systemName: image), for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
}
