//
//  Comment.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 2.04.2024.
//

import Foundation

struct Comment: Decodable {
    let id: Int?
    let postId: Int?
    let name: String?
    let email: String?
    let body: String?
}
