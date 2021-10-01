//
//  NetworkManager.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {

}

final class NetworkManager {

    // MARK: - Properties
    weak var delegate: NetworkManagerDelegate?

}
