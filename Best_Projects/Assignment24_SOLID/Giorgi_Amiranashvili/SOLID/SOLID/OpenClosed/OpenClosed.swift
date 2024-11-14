//
//  OpenClosed.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 13.11.24.
//

import UIKit

/* მოცემულ შემთხვევაში ვიყენებთ პროტოკოლებს და
 extensions, რაც საშუალებას გვაძლევს დავამატოთ
 ბენზინის ახალი ტიპები არსებული DiscountCalculator კლასის შეცვლის გარეშე.
 */

enum UpdatedGasoline {
    case regular
    case premium
    case superPremium
}

protocol UpdatedPrice {
    func price() -> Double
}

extension UpdatedGasoline: UpdatedPrice {
    func price() -> Double {
        switch self {
        case .regular:
            return 5.0
        case .premium:
            return 10.0
        case .superPremium:
            return 15.0
            
        }
    }
}

class UpdatedCalculator {
    func calculatePrice(for gasoline: UpdatedGasoline) -> Double {
        return gasoline.price()
    }
}





