//
//  LogInViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit

class LogInViewController: UIViewController {

    // MARK: - Properties
    private let networkManager = NetworkManager()
    
    private let logInView = LogInView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logInView.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    // MARK: - Functions
    func setUpView() {
        logInView.logInButton.addTarget(self, action: #selector(logInButtonDidTapped), for: .touchUpInside)
        logInView.registerButton.addTarget(self, action: #selector(registerButtonDidPressed), for: .touchUpInside)
    }
    
    @objc func logInButtonDidTapped() {
        
    }
    
    @objc func registerButtonDidPressed() {
        let registerVc = RegisterViewController()
        registerVc.modalTransitionStyle = .flipHorizontal
        registerVc.modalPresentationStyle = .fullScreen
        present(registerVc, animated: true)
    }
}

extension LogInViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverToken(_ token: String) {
        print(token)
    }
}
