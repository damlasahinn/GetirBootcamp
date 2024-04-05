//
//  SearchBarViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 24.03.2024.
//

import UIKit

class SearchBarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    var filteredUsers = [User]()
    var isFiltering: Bool = false
    
    let noResultsView: UIView = {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.alpha = 0
        
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let label = UILabel()
        label.text = "Aranılan bulunamadı"
        label.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(noResultsView)
        noResultsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noResultsView.topAnchor.constraint(equalTo: view.topAnchor),
            noResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noResultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noResultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        

        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let userListURL = URL(string: urlString) else { return }
        
        let users = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userListURL))
        guard let users else { return }
        self.users = users
    }

}

extension SearchBarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = isFiltering ? filteredUsers.count : users.count
                
        if rowCount == 0 {
            showNoResultsView()
        } else {
            hideNoResultsView()
        }
        
        return rowCount
    }
    
    func showNoResultsView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.noResultsView.isHidden = false
            self.noResultsView.alpha = 1.0
        })
    }
    
    func hideNoResultsView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.noResultsView.alpha = 0.0 // Yavaşça kaybolur olması için
        }) { _ in
            self.noResultsView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        if isFiltering {
            cell.textLabel?.text = filteredUsers[indexPath.row].name
        } else {
            cell.textLabel?.text = users[indexPath.row].name
        }
        //cell.detailTextLabel?.text = users[indexPath.row].company?.name
        return cell
    }
    
    
}

extension SearchBarViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { // Bu hem text silerken hem de çarpıya tıklanınca oluşacak sorunu çözer.
            isFiltering = false
            filteredUsers = [User]()
            tableView.reloadData()
        } else {
            isFiltering = true
            filteredUsers = users.filter({ user -> Bool in
                return user.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        filteredUsers = [User]()
        tableView.reloadData()
    }
}
