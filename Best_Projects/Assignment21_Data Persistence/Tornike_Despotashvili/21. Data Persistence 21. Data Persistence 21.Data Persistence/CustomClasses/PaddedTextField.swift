//
//  UITextFieldExtensions.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 02.11.24.
//

import UIKit

class PaddedTextField: UITextField {
    private let textPadding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    
    func configureCustomTextField(isSecure: Bool, placeholder: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        self.isSecureTextEntry = isSecure
        self.placeholder = placeholder
        self.font = UIFont(name: "Sen-Medium", size: 11)
        self.backgroundColor = .textFieldBG
        self.layer.cornerRadius = 12
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
