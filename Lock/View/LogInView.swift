//
//  LogInView.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import UIKit

final class LogInView: UIView {
    
    // MARK: - UI
    lazy var lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lockLogo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.08, green: 0.09, blue: 0.15, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailTextField = ITMOTextField(placeHolderText: "E-Mail")
    
    lazy var passwordTextField = ITMOTextField(placeHolderText: "Пароль")
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 50
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 22)
        button.titleLabel?.textColor = .white
        button.backgroundColor  = UIColor(red: 0.40, green: 0.09, blue: 0.96, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 20)
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Constants.themeBackGroundColor
        addSubview(containerView)
        addSubview(lockImageView)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        buttonsStackView.addArrangedSubview(logInButton)
        buttonsStackView.addArrangedSubview(registerButton)
        containerView.addSubview(textFieldsStackView)
        containerView.addSubview(buttonsStackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    func setConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Lock Image View
        constraints.append(lockImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        constraints.append(lockImageView.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(lockImageView.heightAnchor.constraint(equalToConstant: 120))
        constraints.append(lockImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70))
        
        // Container View
        constraints.append(containerView.bottomAnchor.constraint(equalTo: bottomAnchor))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(containerView.topAnchor.constraint(equalTo: lockImageView.bottomAnchor, constant: 50))
        
        // Email Text Field
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -50))
        
        // Password Text Field
        constraints.append(passwordTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -50))
        
        // Text Fields Stack View
        constraints.append(textFieldsStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        constraints.append(textFieldsStackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 50))
        
        // Log In Button
        constraints.append(logInButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(logInButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -75))
        
        // Register Button
        constraints.append(registerButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(registerButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -75))
        
        // Buttons Stack View
        constraints.append(buttonsStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        constraints.append(buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20))
        
        NSLayoutConstraint.activate(constraints)
    }
}
