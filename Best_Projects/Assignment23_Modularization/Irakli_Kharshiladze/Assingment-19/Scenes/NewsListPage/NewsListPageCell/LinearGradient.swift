//
//  Gradient.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 11.11.24.
//

import UIKit
 
final class LinearGradient: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.colors = [UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 0.4).cgColor, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
        layer.addSublayer(gradientLayer)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
}
