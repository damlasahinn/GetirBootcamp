//
//  ListenerViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class ListenerViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func getDataButton(_ sender: Any) {
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SenderViewController") as! SenderViewController
        senderVC.delegate = self
        present(senderVC, animated: true)
    }
}

extension ListenerViewController: MessageDelegate {
    func sendMessage(text: String) {
        messageLabel.text = text
    }
}
