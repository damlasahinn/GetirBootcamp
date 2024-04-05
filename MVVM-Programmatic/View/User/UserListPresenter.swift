//
//  UserListPresenter.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import Foundation
import UIKit

class UserListPresenter: NSObject, UITableViewDataSource {
    var users: [User]
    var filteredUsers: [User]
    var isFiltered: Bool = false
    
    init(
        users: [User],
        filteredUsers: [User]
    ) {
        self.users = users
        self.filteredUsers = filteredUsers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = isFiltered ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.configure(user: user)
        return cell
    }

    func getUserId(for IndexPath: IndexPath) -> Int {
        let index = IndexPath.row
        if isFiltered {
            users = filteredUsers
        }
        
        guard index < users.count else { return 0}
        
        return users[index].id ?? 0
    }
}
