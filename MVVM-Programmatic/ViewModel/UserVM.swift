//
//  UserVM.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 3.04.2024.
//

import RxMoya
import RxSwift

class UserVM {
    func fetchRemoteUsers() -> Observable<[User]> {
        return .create { observer in
            ForumNetworkManager.shared.getUsers()
                .subscribe { users in
                    observer.onNext(users)
                } onError: { error in
                    observer.onError(error)
                }
        }
    }

}
