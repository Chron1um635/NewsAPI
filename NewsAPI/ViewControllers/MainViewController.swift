//
//  ViewController.swift
//  NewsAPI
//
//  Created by Максим Назаров on 22.09.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var news: [News] = []
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
        networkManager.fetchNews(from: Link.mainUrl.url) { [unowned self] result in
            switch result {
            case .success(let data):
                news = data
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage(index: Int, completion: @escaping(UIImage) -> Void ){
        networkManager.fetchImage(from: news[index].urlToImage ?? "") { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                    completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
