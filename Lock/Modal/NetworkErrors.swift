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
    case noToken
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Отсутсвуют данные с сервера"
        case .noConnection:
            return "Отсутсвует соединения"
        case .noToken:
            return "Отсутствует токен"
        }
    }
}
