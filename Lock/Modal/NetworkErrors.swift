//
//  NetworkErrors.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import Foundation

enum NetworkErrors {
    case noConnection
    case noData
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Error getting data"
        case .noConnection:
            return "Something went wrong"
        }
    }
}
