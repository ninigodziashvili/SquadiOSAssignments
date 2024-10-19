//
//  NumberBtns.swift
//  TBC-Assignment-14
//
//  Created by irakli kharshiladze on 14.10.24.
//

import UIKit

class NumberBtns: UIButton {
    let buttonTitle: String
    let buttonTag: Int
    
    init(buttonTitle: String, buttonTag: Int) {
        self.buttonTitle = buttonTitle
        self.buttonTag = buttonTag
        super.init(frame: .zero)
        createNumberBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createNumberBtn() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(buttonTitle, for: .normal)
        self.tag = buttonTag
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.setTitleColor(buttonTitle == "AC" ? .red : UIColor.label, for: .normal)
    }
}
