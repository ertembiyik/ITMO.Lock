//
//  ITMOTextField.swift
//  Lock
//
//  Created by Ertem Biyik on 02.10.2021.
//

import UIKit

final class ITMOTextField: UIView {
    
    // MARK: - UI
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: "Roboto-Regular", size: 18)
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(textField)
        addSubview(separator)
        
        setConstraints()
    }
    
    convenience init(placeHolderText: String) {
        self.init(frame: CGRect.zero)
        textField.placeholder = placeHolderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        // Text Filed
        constraints.append(textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor))
        
        constraints.append(textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12))
        
        constraints.append(textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12))
        
        // Separator View
        constraints.append(separator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        constraints.append(separator.heightAnchor.constraint(equalToConstant: 2))
        constraints.append(separator.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10))
        constraints.append(separator.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor))
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
