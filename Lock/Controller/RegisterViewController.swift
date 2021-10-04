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
        registerView.emailTextField.textField.delegate = self
        registerView.nameTextField.textField.delegate = self
        registerView.surnameTextField.textField.delegate = self
        registerView.passwordTextField.textField.delegate = self
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerView.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    // MARK: - Functions
    private func setUpView() {
        registerView.registerButton.addTarget(self, action: #selector(registerButtonDidTapped), for: .touchUpInside)
        registerView.logInButton.addTarget(self, action: #selector(logInButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonDidTapped() {
        registerView.emailTextField.textField.resignFirstResponder()
        registerView.nameTextField.textField.resignFirstResponder()
        registerView.surnameTextField.textField.resignFirstResponder()
        registerView.passwordTextField.textField.resignFirstResponder()

        guard let email = registerView.emailTextField.textField.text,
              let name = registerView.nameTextField.textField.text,
              let surname = registerView.surnameTextField.textField.text,
              let password = registerView.passwordTextField.textField.text,
              !email.isEmpty,
              !name.isEmpty,
              !surname.isEmpty,
              !password.isEmpty
              
        else {
            showAlert(with: "Ошибка", message: "Пожалуйста введите всю информацию", style: .alert)
            return
        }

        registerView.spinner.show(in: self.view)
        
        networkManager.register(email: email, password: password, name: name, surname: surname)
    }
    
    @objc private func logInButtonDidTapped() {
        let logInVc = LogInViewController()
        logInVc.modalTransitionStyle = .flipHorizontal
        logInVc.modalPresentationStyle = .fullScreen
        present(logInVc, animated: true)
    }
    
}

extension RegisterViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.registerView.spinner.dismiss()
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func signIn() {
        DispatchQueue.main.async {
            self.registerView.spinner.dismiss()
            let vc = LocksTableViewController()
            let navVc = UINavigationController(rootViewController: vc)
            navVc.modalPresentationStyle = .fullScreen
            self.present(navVc, animated: true)
        }
    }
        
}

// MARK: - Extensions
extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == registerView.emailTextField.textField {
            registerView.nameTextField.textField.becomeFirstResponder()
        } else if textField == registerView.nameTextField.textField {
            registerView.surnameTextField.textField.becomeFirstResponder()
        } else if textField == registerView.surnameTextField.textField {
            registerView.passwordTextField.textField.becomeFirstResponder()
        } else if textField == registerView.passwordTextField.textField {
            registerButtonDidTapped()
        }

        return true
    }
}
