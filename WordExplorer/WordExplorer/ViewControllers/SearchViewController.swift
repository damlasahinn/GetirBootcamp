//
//  ViewController.swift
//  WordExplorer
//
//  Created by Damla Sahin on 20.03.2024.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var searchText: String?
    var lastFiveSearches = [String]() {
        didSet {
            if lastFiveSearches.count > 5 {
                lastFiveSearches.removeFirst(lastFiveSearches.count - 5)
            }
            UserDefaults.standard.set(lastFiveSearches, forKey: "lastFiveSearches")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedSearches = UserDefaults.standard.array(forKey: "lastFiveSearches") as? [String] {
            lastFiveSearches = savedSearches
        }
        
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            bottomConstraint.constant = keyboardHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 8 
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func hideKeyboard() {
        view.endEditing(true) 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.receivedText = searchText
                detailVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    @IBAction func searchAction(_ sender: Any) {
        searchBar.resignFirstResponder()
           if let searchText = searchBar.text, !searchText.isEmpty {
               performSearchAction(with: searchText)
           }
    }
    
    func performSearchAction(with searchText: String) {
        if let index = lastFiveSearches.firstIndex(of: searchText) {
            lastFiveSearches.remove(at: index)
        }
        
        self.searchText = searchText
        lastFiveSearches.append(searchText)
        tableView.reloadData()
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        print(searchText)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastFiveSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchTextCell", for: indexPath) as? SearchTextCell else {
            fatalError("The dequeued cell is not an instance of SearchTextCell.")
        }
        
        let searchText = lastFiveSearches.reversed()[indexPath.row]
        cell.configure(searchText: searchText)
        cell.onSearchAction = { [weak self] searchText in
            self?.performSearchAction(with: searchText)
        }
        
        return cell
    }
      
}
