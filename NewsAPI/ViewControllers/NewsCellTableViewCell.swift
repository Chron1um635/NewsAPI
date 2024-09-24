//
//  NewsCellTableViewCell.swift
//  NewsAPI
//
//  Created by Максим Назаров on 23.09.2024.
//

import UIKit

class NewsCellTableViewCell: UITableViewCell {
    
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    

    func configure(with news: Article) {
        titleLabel.text = news.title
        
        guard let imageUrl = URL(string: news.urlToImage ?? "") else { return }
        networkManager.fetchImage(from: imageUrl) {[weak self] result in
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
