//
//  ViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Merhaba uygulama ayağa kalktı.")
        
        /*let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        let label = UILabel(frame: frame)
        
        label.backgroundColor = .red
        //label.textColor = .white
        label.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        //label.font = UIFont(name: "Avenir", size: 20)
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0 //kaç satırsa o kadar satuıra sığar.
        label.text  = "Getir Bootcampe hoşgeldiniz"
        label.isUserInteractionEnabled = true
        view.addSubview(label)*/
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.orange, for: .normal)
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let messageText = messageTextField.text, !messageText.isEmpty else { //isEmpty yerine messageText.count > 0 aynı işi yapar.
            return
        }
        messageLabel.text = messageText
        messageTextField.text = ""
        messageTextField.resignFirstResponder()

    }
    
}

