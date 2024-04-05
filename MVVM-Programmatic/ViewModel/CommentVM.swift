//
//  CommentVM.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import RxSwift
import RxMoya

class CommentVM {
    func fetchComments(for postId: Int) -> Observable<[Comment]> {
        return Observable.create { observer in
            ForumNetworkManager.shared.getComments(for: postId)
                .subscribe{ comments in
                    observer.onNext(comments)
                } onError: { error in
                    print(error)
                    observer.onError(error)
                }
            return Disposables.create()
        }
    }
}
