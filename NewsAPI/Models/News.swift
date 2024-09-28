//
//  News.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//


struct News {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
    init(news: [String: Any]) {
        source = news["source"] as? Source ?? Source(name: "")
        author = news["author"] as? String ?? ""
        title = news["title"] as? String ?? ""
        description = news["description"] as? String ?? ""
        url = news["url"] as? String ?? ""
        urlToImage = news["urlToImage"] as? String ?? ""
        publishedAt = news["publishedAt"] as? String ?? ""
    }
    
    static func getNews(for value: Any) -> [News] {
        guard let newsDetails = value as? [String: Any] else { return [] }
        guard let news = newsDetails["articles"] as? [[String: Any]] else { return [] }
        return news.map {News(news: $0)}
    }
    
}


struct Source {
    let name: String
    
}

