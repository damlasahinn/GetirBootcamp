//
//  ViewController.swift
//  Storage
//
//  Created by Damla Sahin on 30.03.2024.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {
    
    let keychain = Keychain(service: "com.getirbootcamp.storage")

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let message = UserDefaults.standard.value(forKey: "message") as? String
        let message = keychain["message"]
        messageLabel.text = message
    }


    @IBAction func saveMessage(_ sender: Any) {
        let message = messageTextField.text
//        DispatchQueue.main.async {
//            UserDefaults.standard.setValue(message, forKey: "message")
//        }
        keychain["message"] = message
        messageLabel.text = message
        messageTextField.text = ""
        
    }
    
    //UserDefaults plain text olarak tutar.
    //pentestte userdaults kullanılmış verileri görürler
}

