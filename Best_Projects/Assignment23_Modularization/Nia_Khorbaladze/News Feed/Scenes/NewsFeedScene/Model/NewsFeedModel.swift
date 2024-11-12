//
//  NewsFeedModel.swift
//  News Feed
//
//  Created by Nkhorbaladze on 30.10.24.
//

import Foundation

struct Article: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct NewsFeedData: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

