//
//  DetailsViewController.swift
//  NewsAPI
//
//  Created by Максим Назаров on 23.09.2024.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var newsImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    var news: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        authorLabel.text = news.author
        publishedAtLabel.text = news.publishedAt
        
        guard let imageUrl = URL(string: news.urlToImage ?? "") else { return }
        networkManager.fetchImage(from: imageUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                newsImageView.image = UIImage(data: data)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(named: "noImage")
                }
                print(error)
            }
        }
    }
    

}

