//
//  NewsCell.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var newsImageview: UIImageView!
    @IBOutlet weak var newsDetailView: UILabel!
    @IBOutlet weak var newsTitleView: UILabel!
    
    func setup(model: News) {
        newsImageview.image = model.imageView
        newsTitleView.text = model.title
        newsDetailView.text = model.detail
    }
}
