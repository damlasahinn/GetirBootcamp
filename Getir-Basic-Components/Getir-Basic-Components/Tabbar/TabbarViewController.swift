//
//  TabbarViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 24.03.2024.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    let middleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let tabbar = tabBarController?.tabBar else { return }
//        tabbar.backgroundColor = .blue
//        tabbar.tintColor = .yellow
//        tabbar.unselectedItemTintColor = .red
//        tabbar.layer.cornerRadius = 30
//        tabbar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        tabbar.layer.masksToBounds = true // Bu ne işe yarar? Mask to Bound ile clip to Bound arasındaki fark nedir
//        tabbar.layer.borderWidth = 2
//        tabbar.layer.borderColor = UIColor.black.cgColor
        //Orta button hafif önde olacak şekilde nasıl yapılıyor. örnek yapınız.
        //Itemlar çok  altta normalde daha yukarda daha yukarda durmaz mı bunu nasıl yapıyoruz.
        
        setupMiddleButton()
        customizeTabBar()
    }
    
    func setupMiddleButton() {
        middleButton.frame.size = CGSize(width: 70, height: 70)
        middleButton.backgroundColor = .yellow
        middleButton.layer.cornerRadius = middleButton.frame.height / 2
        middleButton.layer.masksToBounds = true
        middleButton.setImage(UIImage(systemName: "plus"), for: .normal)
        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        middleButton.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.minY - middleButton.frame.height / 2)
        tabBar.addSubview(middleButton)
        tabBar.bringSubviewToFront(middleButton)
    }

    @objc func middleButtonAction() {
        // Orta butona basıldığında yapılacak işlemler
    }

    func customizeTabBar() {
        guard let numberOfItems = tabBar.items?.count else { return }
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(numberOfItems), height: tabBar.frame.height)

        
        tabBar.backgroundColor = .blue
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .red
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        tabBar.layer.borderWidth = 2
        tabBar.layer.borderColor = UIColor.black.cgColor
        
    }
}
