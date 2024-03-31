//
//  DetailCell.swift
//  WordExplorer
//
//  Created by Damla Sahin on 21.03.2024.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var exampleStackView: UIStackView!
    @IBOutlet weak var exampleTitleLabel: UILabel!
    @IBOutlet weak var partOfSpeech: UILabel!
    @IBOutlet weak var definitonLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with meaning: Meaning) {
        if let definition = meaning.definitions.first {
            definitonLabel.text = definition.definition
            if let exampleText = definition.example, !exampleText.isEmpty {
                exampleLabel.text = exampleText
                exampleLabel.isHidden = false
                exampleTitleLabel.isHidden = false
                exampleStackView.isHidden = false
            } else {
                exampleLabel.isHidden = true
                exampleTitleLabel.isHidden = true
                exampleStackView.isHidden = true
            }
        }
        partOfSpeech.text = meaning.partOfSpeech
        
        layoutIfNeeded()
    }

}
