//
//  ForumServiceExtension.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import Foundation
import Moya

extension ForumService: TargetType {
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserPosts(let userId):
            return "/users/\(userId)/posts"
        case .getPostComments(let postId):
            return "/posts/\(postId)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .getUsers, .getUserPosts, .getPostComments:
            return .get
        }
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

