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
            return "Проверьте правильность данных"
        case .noConnection:
            return "Отсутствует соединение"
        case .noToken:
            return "Отсутствует токен"
        }
    }
}
