//
//  CookListViewController.swift
//  Storage
//
//  Created by Damla Sahin on 30.03.2024.
//

import UIKit
import CoreData

class CookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cookNames = [String]()
    var cookImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getcooks()
    }
    

    private func getcooks() {
        cookNames.removeAll()
        cookImages.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cooks")
        
        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return }
                    guard let imageData = result.value(forKey: "image") as? Data else { return }
                    guard let image = UIImage(data: imageData) as? UIImage else { return }
                    cookImages.append(image)
                    cookNames.append(name)
                }
                tableView.reloadData()
            } else {
                //Alert ile veri kaydı bulunamadı.
            }
        } catch {
            print("Veriler çekilemedi.")
        }
    }

}

extension CookListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cookNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cookNames[indexPath.row]
        let resizedImage = resizeImage(image: cookImages[indexPath.row], targetSize: CGSize(width: 40, height: 40))
        cell.imageView?.image = resizedImage
        
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cookNameToDelete = cookNames[indexPath.row]
            
            cookNames.remove(at: indexPath.row)
            cookImages.remove(at: indexPath.row)
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Cooks> = Cooks.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", cookNameToDelete)
            
            do {
                let objects = try context.fetch(fetchRequest)
                for object in objects {
                    context.delete(object)
                }
                
                try context.save()
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting object: \(error)")
            }
        }
    }
    
}
