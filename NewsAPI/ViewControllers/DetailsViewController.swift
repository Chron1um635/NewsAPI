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
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        authorLabel.text = news.author
        publishedAtLabel.text = news.publishedAt
    
        networkManager.fetchImage(from: news.urlToImage ?? "") { [weak self] result in
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
        newsImageView.layer.cornerRadius = newsImageView.frame.height / 2
    }
    

}

