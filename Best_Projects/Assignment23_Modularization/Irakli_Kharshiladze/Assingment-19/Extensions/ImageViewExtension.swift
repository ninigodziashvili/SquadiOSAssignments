//
//  ImageViewExtension.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 10.11.24.
//

import Foundation
import UIKit

extension UIImageView{
    func imageFrom(url:URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data:data){
                    DispatchQueue.main.async{
                        self?.image = image
                    }
                }
            }
        }
    }
}
