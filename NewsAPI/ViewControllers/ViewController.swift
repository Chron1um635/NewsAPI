//
//  ViewController.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
    }


    
}

// MARK: - Network
private extension ViewController {
    func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2024-08-22&sortBy=publishedAt&apiKey=dfe5b2f4813e4781a9f27647aa6fd1a7") else { return }
        URLSession.shared.dataTask(with: url) { data ,_, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                print(news)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
