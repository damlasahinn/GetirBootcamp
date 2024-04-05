//
//  User.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 24.03.2024.
//

import Foundation

struct User: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let isAdmin: Bool?
    let company: Company?
}

struct Company: Decodable {
    let name: String?
}
