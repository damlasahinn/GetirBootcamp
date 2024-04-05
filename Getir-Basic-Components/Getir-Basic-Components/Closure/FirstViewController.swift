//
//  FirstViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 29.03.2024.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textedit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendTapped(_ sender: Any) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        
        secondVC.modalPresentationStyle = .fullScreen
        
        secondVC.callback = { [weak self] text in
            self?.textedit.text = text
        }
        secondVC.displayText(textedit.text ?? "default")
        present(secondVC, animated: true, completion: nil)
    }
    
}
