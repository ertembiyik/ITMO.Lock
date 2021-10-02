//
//  ClassRoomViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit

class ClassRoomViewController: UIViewController {

    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        networkManager.getLockInfo(lockId: "1")
    }
    
}

extension ClassRoomViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverLockInfo(lockInfo: LockInfo) {
        print(lockInfo)
    }
}
