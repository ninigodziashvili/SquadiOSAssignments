//
//  newsModel.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

struct News: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

final class Article: Decodable {
    let source: Source
    let author: String
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String
    let publishedAt: String?
    let content: String
}

struct Source: Decodable {
    let id: String
    let name: String
}
