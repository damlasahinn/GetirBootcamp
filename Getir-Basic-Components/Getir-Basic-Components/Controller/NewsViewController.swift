//
//  NewsViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.delegate = self
        collectionView.dataSource = self
        
        let news1 = News(imageView: #imageLiteral(resourceName: "corek"), title: "Title 1", detail: "Detail 1")
        let news2 = News(imageView: #imageLiteral(resourceName: "boyoz"), title: "Title 1", detail: "Detail 1")
        let news3 = News(imageView: #imageLiteral(resourceName: "simit"), title: "Title 1", detail: "Detail 1")
    }


}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        cell.setup(model: news[indexPath.row])
        return cell
    }

    
    
}
