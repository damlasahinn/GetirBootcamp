//
//  CommentListPresenter.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import Foundation
import UIKit

class CommentListPresenter: NSObject, UITableViewDataSource {
    var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comment = comments[indexPath.row]
        cell.configure(comment: comment)
        return cell
    }
}
