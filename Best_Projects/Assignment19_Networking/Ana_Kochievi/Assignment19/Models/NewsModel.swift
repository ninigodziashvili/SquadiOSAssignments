//
//  NewsModel.swift
//  Assignment19
//
//  Created by MacBook on 30.10.24.
//

import Foundation

struct NewsData: Decodable {
    var news: [NewsModel]?
}

struct NewsModel: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Article: Decodable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}

struct Source: Decodable {
    var id: String?
    var name: String?
}

