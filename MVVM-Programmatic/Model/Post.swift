//
//  Post.swift
//  MVVM-Programmatic
//
//  Created by Damla Sahin on 2.04.2024.
//

import Foundation

import Foundation

struct Post: Decodable {
    let id: Int?
    let userId: Int?
    let title: String?
    let body: String?
}
