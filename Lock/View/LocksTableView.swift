//
//  ClassRoomsTableView.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit

class LocksTableView: UIView {
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(LocksTableViewCell.self, forCellReuseIdentifier: LocksTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Constants.themeBackGroundColor
        tableView.backgroundColor = Constants.themeBackGroundColor
        tableView.separatorStyle = .none
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LocksTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "locksTableViewCell"
    
    // MARK: - UI
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.accentColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var indicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(cellLabel)
        containerView.addSubview(indicator)
        contentView.addSubview(containerView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    func setConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        // Text Filed
        constraints.append(cellLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor))
        
        constraints.append(cellLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30))
        
        // Indicator
        constraints.append(indicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor))
        
        constraints.append(indicator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20))
        
        constraints.append(indicator.heightAnchor.constraint(equalToConstant: 17))
        constraints.append(indicator.widthAnchor.constraint(equalToConstant: 8))
        
        // Container View
        constraints.append(containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22))
        constraints.append(containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
        constraints.append(containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10))
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
