//
//  SecondViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 29.03.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    var textToDisplay: String?
    var callback: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let textToDisplay = textToDisplay {
            displayLabel.text = textToDisplay
        }
    }

    func displayText(_ text: String) {
        if displayLabel != nil {
            displayLabel.text = text
        } else {
            textToDisplay = text
        }
    }
}
