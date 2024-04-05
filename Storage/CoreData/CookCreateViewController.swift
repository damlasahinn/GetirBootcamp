//
//  CookCreateViewController.swift
//  Storage
//
//  Created by Damla Sahin on 30.03.2024.
//

import UIKit
import CoreData

class CookCreateViewController: UIViewController {

    @IBOutlet weak var cookNameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(tap)
        
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    @IBAction func cookSaveAction(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Cooks", into: context)
        
        newCook.setValue(cookNameTextField.text, forKey: "name")
        
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        
        newCook.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        navigationController?.popViewController(animated: true)
        //
    }
 

}
extension CookCreateViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
}
