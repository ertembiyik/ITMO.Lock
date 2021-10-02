//
//  RegisterViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    private let networkManager = NetworkManager()
    
    private let registerView = RegisterView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerView.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    // MARK: - Functions
    func setUpView() {
        registerView.registerButton.addTarget(self, action: #selector(registerButtonDidPressed), for: .touchUpInside)
        registerView.logInButton.addTarget(self, action: #selector(logInButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func registerButtonDidPressed() {
        
    }
    
    @objc func logInButtonDidTapped() {
        let logInVc = LogInViewController()
        logInVc.modalTransitionStyle = .flipHorizontal
        logInVc.modalPresentationStyle = .fullScreen
        present(logInVc, animated: true)
        
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
