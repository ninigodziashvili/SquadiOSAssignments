//
//  PortfolioViewModel.swift
//  MyPortfolio
//
//  Created by Giorgi Amiranashvili on 08.12.24.
//

import Foundation

class PortfolioViewModel {
    func modifyToData(_ experiences: [Experiance]) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(experiences)
            return jsonData
        }
        catch {
            return nil
        }
    }
    
    func modifyFromData(_ data: Data) -> [Experiance]? {
        do {
            let experiences = try JSONDecoder().decode([Experiance].self, from: data)
            return experiences
        }
        catch {
            return nil
        }
    }
}
