//
//  NotificationListenerVC.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class NotificationListenerVC: UIViewController {

    @IBOutlet weak var messageImageView: UIImageView!
    var images = ["simit", "kebap", "boyoz", "corek", "sut"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter: NotificationCenter = .default
        notificationCenter.addObserver(self, selector: #selector(changeImage), name: .sendDataNotification, object: nil)
    }
    
    @objc func changeImage() {
        messageImageView.image = UIImage(named: images.randomElement() ?? "simit")
    }
   
    
}
