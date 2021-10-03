//
//  ClassRoomView.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit
import JGProgressHUD
class ClassRoomView: UIView {
    
    // MARK: - UI
    lazy var spinner = JGProgressHUD(style: .dark)
    
    lazy var classImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor(red: 0.98, green: 0.10, blue: 0.63, alpha: 1.0).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.text = "Проход в коворкинг и лекционную."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.57, green: 0.58, blue: 0.61, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var openTheDoorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("Открыть", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 22)
        button.titleLabel?.textColor = .white
        button.backgroundColor  = UIColor(red: 0.40, green: 0.09, blue: 0.96, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Constants.themeBackGroundColor
        addSubview(classImageView)
        addSubview(descriptionLabel)
        addSubview(openTheDoorButton)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    func setConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        // Class Image View
        constraints.append(classImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70))
        constraints.append(classImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        constraints.append(classImageView.heightAnchor.constraint(equalToConstant: 270))
        constraints.append(classImageView.widthAnchor.constraint(equalToConstant: 270))
        
        // Description Label
        constraints.append(descriptionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: classImageView.bottomAnchor, constant: 50))
        constraints.append(descriptionLabel.heightAnchor.constraint(equalToConstant: 50))
        
        //  Button
        constraints.append(openTheDoorButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(openTheDoorButton.widthAnchor.constraint(equalToConstant: 250))
        constraints.append(openTheDoorButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor))
        constraints.append(openTheDoorButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80))
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
