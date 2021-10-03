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
        logInView.emailTextField.textField.delegate = self
        logInView.passwordTextField.textField.delegate = self
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logInView.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    // MARK: - Functions
    func setUpView() {
        logInView.logInButton.addTarget(self, action: #selector(logInButtonDidTapped), for: .touchUpInside)
        logInView.registerButton.addTarget(self, action: #selector(registerButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func logInButtonDidTapped() {
        logInView.emailTextField.textField.resignFirstResponder()
        logInView.passwordTextField.textField.resignFirstResponder()

        guard let email = logInView.emailTextField.textField.text,
              let password = logInView.passwordTextField.textField.text,
              !email.isEmpty,
              !password.isEmpty
              
        else {
            showAlert(with: "Ошибка", message: "Пожалуйста введите всю информацию", style: .alert)
            return
        }

        // TODO: - Spinner
        
        networkManager.logIn(email: email, password: password)
    }
    
    @objc func registerButtonDidTapped() {
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
    
    func signIn() {
        DispatchQueue.main.async {
            let vc = LocksTableViewController()
            let navVc = UINavigationController(rootViewController: vc)
            navVc.modalPresentationStyle = .fullScreen
            self.present(navVc, animated: true)
        }
    }
}

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == logInView.emailTextField.textField {
            logInView.passwordTextField.textField.becomeFirstResponder()
        } else if textField == logInView.passwordTextField.textField {
            logInButtonDidTapped()
        }
        return true
    }
}
