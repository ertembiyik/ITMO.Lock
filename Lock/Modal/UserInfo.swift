//
//  UserInfo.swift
//  Lock
//
//  Created by Ertem Biyik on 04.10.2021.
//

import Foundation

struct UserInfo: Codable {
    let email: String
    let name: String
    let surname: String
    let id: Int
    let is_admin: Bool
}
