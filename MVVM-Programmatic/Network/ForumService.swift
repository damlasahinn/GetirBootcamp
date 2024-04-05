//
//  ForumService.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 2.04.2024.
//

import Foundation

enum ForumService {
    case getUsers
    case getUserPosts(_ userId: Int)
    case getPostComments(_ postId: Int)
}
