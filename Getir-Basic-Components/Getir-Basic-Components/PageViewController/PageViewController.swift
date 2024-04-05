//
//  PageViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 30.03.2024.
//

import UIKit

class PageViewController: UIViewController {
    
    var controllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        controllers.append(vc1)
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .red
        controllers.append(vc2)
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .red
        controllers.append(vc3)
        
    }
    
    private func pageVC() {
        guard let first = controllers.first else { return }
        
        let vc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        vc.modalPresentationStyle = .fullScreen
        vc.setViewControllers([first], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        present(vc, animated: true)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        
        let previous = index - 1
        
        return controllers[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1 ) else { return nil }
        
        let next = index + 1
        
        return controllers[next]
    }
    
    
}

//HW: Onboarding page with pageControl (PageViewController & Collection View)
// Otomatik geçişi de deneyebilirsiniz.
//event hangi sayfada hangi butonu tıkladı. Kullanıcı yol haritası izlemek için. Firebase Event, Inside,
//Kampanya kodu kaç kişi satın aldı da kullanılabilir.
//crashlytic: Firebase altında. Crash bildirim öderme
//Deeplink Deeplink, bir mobil uygulama içinde belirli bir sayfaya veya içeriğe yönlendiren bir bağlantıdır. Geleneksel bağlantılardan farklı olarak, genellikle ana sayfa yerine doğrudan belirli bir noktaya yönlendirme yapar. Bu sayede kullanıcılar, istedikleri içeriğe daha hızlı erişebilirler.
