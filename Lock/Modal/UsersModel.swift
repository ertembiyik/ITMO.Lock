//
//  UsersModel.swift
//  Lock
//
//  Created by Ertem Biyik on 04.10.2021.
//

import Foundation

struct UsersModel: Codable {
    let users: [UserModel]
}

struct UserModel: Codable {
    let locks: [Int]
    let name: String
    let surname: String
    let id: Int
}
