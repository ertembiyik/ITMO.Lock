//
//  RegisterViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
    }
}

extension RegisterViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverToken(_ token: String) {
        print(token)
    }
        
}
