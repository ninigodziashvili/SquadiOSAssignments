//
//  News_ViewModel.swift
//  Assignment19
//
//  Created by nino on 10/30/24.
//

import Foundation
import UIKit

final class News_ViewModel {
    
    private let networkService = NetworkService()
    
    var newsArray = [NewsModel]()
    
    var newsChanged: (()->Void)?
    
    init() {
        getNewsFrom()
    }
    
    func currentNews(at index: Int) -> NewsModel {
        newsArray[index]
    }
    
    var numberOfNews: Int {
        newsArray.count
    }
    
    func getNewsFrom() {
        networkService.getNewsFrom { data, error in
            self.newsArray = data?.articles ?? []
            self.newsChanged?()
        }
    }
}


