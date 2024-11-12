//
//  NewsArticle.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import Foundation

public struct ArticlesResponse: Codable, Sendable {
    public let articles: [NewsArticle]
}

public struct NewsArticle: Codable, Sendable {
    public let title: String
    public let author: String?
    public let publishedAt: String
    public let urlToImage: String?
    public let description: String?
}
