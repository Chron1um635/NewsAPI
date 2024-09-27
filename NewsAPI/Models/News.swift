//
//  News.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//


struct News {
    var articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
    
    init(news: [String: Any]?) {
        self.articles = []
        let articles = news?["articles"] as? [[String: Any]]
        var someArticles: [Article] = []
        articles?.forEach { article in
            let art = Article(news: article)
            someArticles.append(art)
        }
        self.articles.append(contentsOf: someArticles)
    }
    
}

struct Article {
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
}


struct Source {
    let name: String
    
}

