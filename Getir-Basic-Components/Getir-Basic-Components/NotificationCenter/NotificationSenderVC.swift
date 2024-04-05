//
//  NotificationSenderVC.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class NotificationSenderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendNotification(_ sender: Any) {
        NotificationCenter.default.post(name: .sendDataNotification, object: nil)
        dismiss(animated: true)
    }

}
