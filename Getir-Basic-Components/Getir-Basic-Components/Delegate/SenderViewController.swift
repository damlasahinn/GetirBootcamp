//
//  SenderViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

protocol MessageDelegate: AnyObject {
    func sendMessage(text: String)
}

class SenderViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    weak var delegate: MessageDelegate? // sadece classlarda kullanacağımızdan eminsek AnyObject yaz protocole
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func sendMesssageButton(_ sender: Any) {
        guard let text = messageTextField.text else { return }
        
        delegate?.sendMessage(text: text)
        dismiss(animated: true)
    }
    

}
