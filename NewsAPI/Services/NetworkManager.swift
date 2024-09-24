//
//  NetworkManager.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//

import Foundation

enum NetworkError: String, Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchNews(
        from url: URL,
        completion: @escaping(
            Result<
            News,
            NetworkError
            >
        ) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data ,_, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                completion(.success(news))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(
        from url: URL,
        completion: @escaping(
            Result<Data, NetworkError>
        ) -> Void
    ) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
