//
//  SearchTextCell.swift
//  WordExplorer
//
//  Created by Damla Sahin on 25.03.2024.
//

import UIKit

class SearchTextCell: UITableViewCell {

    @IBOutlet weak var searchTextLabel: UITextField!
    var onSearchAction: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(searchText: String) {
        searchTextLabel.text = searchText
    }

    @IBAction func searchAction(_ sender: Any) {
        if let searchText = searchTextLabel.text {
            onSearchAction?(searchText)
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if let searchText = searchTextLabel.text {
            onSearchAction?(searchText)
        }
    }
}
