//
//  NetworkManager.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//

import Foundation
import Alamofire

enum Link {
    case mainUrl
    
    var url: URL {
        switch self {
        case .mainUrl:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=dfe5b2f4813e4781a9f27647aa6fd1a7")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchNews(from url: URL, completion: @escaping(Result<News, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let news = News(news: data as? [String: Any])
                    completion(.success(news))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
