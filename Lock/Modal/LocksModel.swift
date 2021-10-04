//
//  LocksModel.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import Foundation

struct LocksModel: Codable {
    let locks: [LockModel]
}

struct LockModel: Codable {
    let number: String
    let preview: String
    let about: String
    let id: Int
}
