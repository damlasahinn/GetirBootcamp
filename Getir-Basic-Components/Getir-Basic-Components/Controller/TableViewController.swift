//
//  TableViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 23.03.2024.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var cities = ["Ankara", "Tokat", "İzmir", "Amasya", "Adana"]
//    var famous = ["Simit", "Tokat Kebabı", "Boyoz", "Çörek", "Muzlu Süt"]
//    var images = ["simit", "kebap", "boyoz", "corek", "sut"] // Assets'e ekle bu isimde resimleri ekle.
    
    var myCities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCities.append(City(name: "Ankara", famous: "Simit", image: "simit"))
        myCities.append(City(name: "Tokat", famous: "Tokat Kebabı", image: "kebap"))
        myCities.append(City(name: "İzmir", famous: "Boyoz", image: "boyoz"))
        myCities.append(City(name: "Amasya", famous: "Çörek Süt", image: "corek"))
        myCities.append(City(name: "Adana", famous: "Muzlu Süt", image: "sut"))
        
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell") ///celle CityCell i atamak yerine bunu yapıyoruz crash olmamaması için
    }
    
}
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myCities.count
    }
    
    //KingFisher, SDWebImage, AlamofireImage
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
//        cell.textLabel?.text = myCities[indexPath.row].name // .item farkı item collection viewde kullanılır
//        cell.detailTextLabel?.text = myCities[indexPath.row].famous
//        cell.imageView?.image = UIImage(named: myCities[indexPath.row].image)
        cell.setup(model: myCities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(myCities[indexPath.row].name)")
        let alertController = UIAlertController(title: myCities[indexPath.row].name, message: myCities[indexPath.row].famous, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
        
    }
    
}
