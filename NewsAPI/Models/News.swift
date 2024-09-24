//
//  News.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//


struct News: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}


struct Source: Decodable {
    let name: String
}

