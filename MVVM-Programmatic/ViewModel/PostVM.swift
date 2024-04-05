//
//  PostVM.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import RxSwift
import RxMoya

class PostVM {
    func fetchPosts(for userId: Int) -> Observable<[Post]> {
        return Observable.create { observer in
            ForumNetworkManager.shared.getUserPost(for: userId)
                .subscribe { posts in
                    observer.onNext(posts)
                } onError: { error in
                    print(error)
                    observer.onError(error)
                }
            return Disposables.create()
        }
    }
}

