//
//  NewsCellTableViewCell.swift
//  NewsAPI
//
//  Created by Максим Назаров on 23.09.2024.
//

import UIKit

final class NewsCellTableViewCell: UITableViewCell {
    
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    

    func configure(with news: Article) {
        titleLabel.text = news.title
        
        networkManager.fetchImage(from: news.urlToImage ?? "") {[weak self] result in
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
