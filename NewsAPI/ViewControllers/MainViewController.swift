//
//  ViewController.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//

import UIKit

class MainViewController: UITableViewController {
    
    private var news: [News] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
    }


    
}

// MARK: UITableViewDelegate
extension MainViewController

// MARK: - Network
private extension MainViewController {
    func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2024-08-22&sortBy=publishedAt&apiKey=dfe5b2f4813e4781a9f27647aa6fd1a7") else { return }
        networkManager.fetchNews(from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
