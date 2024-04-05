//
//  ViewController.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 2.04.2024.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let userVM = UserVM()
    private lazy var userList: UserListPresenter = {
       let config = UserListPresenter(users: [], filteredUsers: [])
        return config
    }()
    
    let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    let searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "SearchUser"
        return searchController
    }()
    
    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userVM.fetchRemoteUsers().subscribe { [weak self] users in
            guard let self else { return }
            self.userList.users = users
            tableView.reloadData()
        } onError: { error in
            print(error.localizedDescription)
        } onCompleted: {
            print("Completed")
        } onDisposed: {
            print("Completed")
        }.disposed(by: disposeBag)
    }

    private func configureProperties() {
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = userList
        navigationItem.title = "Users"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false 
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        userList.filteredUsers = userList.users.filter({ (user: User) -> Bool in
            userList.isFiltered = searchController.isActive && !isSearchBarEmpty
            guard let name = user.name else { return false }
            return name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = userList.getUserId(for: indexPath)
        let postViewController = PostViewController(userId: userId)
        
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
