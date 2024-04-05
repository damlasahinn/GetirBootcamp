//
//  PostListPresenter.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import Foundation
import UIKit

class PostListPresenter: NSObject, UITableViewDataSource {
    
    var posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(post: post)
        cell.onShowMoreTapped = { [weak tableView] in
            guard let tableView = tableView else { return }
            
            if let indexPath = tableView.indexPath(for: cell) {
                tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
            }
        }
        return cell
    }

    
    func getPostId(for IndexPath: IndexPath) -> Int {
        let index = IndexPath.row
        
        guard index < posts.count else { return 0}
        
        return posts[index].id ?? 0
    }
}
