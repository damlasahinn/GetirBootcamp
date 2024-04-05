//
//  ForumNetworkManager.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import RxSwift
import Moya
import RxMoya

enum CustomError: Error {
    case unknown
}

struct ForumNetworkManager {
    static let shared = ForumNetworkManager()
    private let provider = MoyaProvider<ForumService>()
    
    func getUsers() -> Single<[User]> {
        return provider.rx
            .request(.getUsers)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([User].self)
    }
    
    func getUserPost(for userId: Int) -> Single<[Post]> {
        return provider.rx
            .request(.getUserPosts(userId))
            .filterSuccessfulStatusAndRedirectCodes()
            .map([Post].self)
    }

    func getComments(for postId: Int) -> Single<[Comment]> {
        return provider.rx
            .request(.getPostComments(postId))
            .filterSuccessfulStatusAndRedirectCodes()
            .map([Comment].self)
    }
}



