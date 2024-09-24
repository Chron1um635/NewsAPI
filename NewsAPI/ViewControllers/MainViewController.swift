//
//  ViewController.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var news: [Article] = []
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let detailsVC = segue.destination as? DetailsViewController
        detailsVC?.news = news[indexPath.row]
    }
    
}

// MARK: UITableViewDelegate
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCellTableViewCell else { return UITableViewCell()}
        cell.configure(with: news[indexPath.row])
        
        return cell
    }
}

// MARK: - Network
private extension MainViewController {
    func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2024-08-24&sortBy=publishedAt&apiKey=dfe5b2f4813e4781a9f27647aa6fd1a7") else { return }
        networkManager.fetchNews(from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                news = data.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage(index: Int, completion: @escaping(UIImage) -> Void ){
        guard let url = URL(string: news[index].urlToImage ?? "") else { return}
        networkManager.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
