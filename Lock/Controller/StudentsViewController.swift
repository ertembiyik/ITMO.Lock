//
//  StudentsViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit

class StudentsViewController: UIViewController {

    // MARK: - Properties
    private let networkManager = NetworkManager()
    
    private var students = [UserModel]()
    
    private var lockId: Int
    
    private let studentsView = StudentsView()
    
    init(lockId: Int) {
        self.lockId = lockId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = studentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        networkManager.delegate = self
        studentsView.tableView.delegate = self
        studentsView.tableView.dataSource = self
        studentsView.spinner.show(in: self.view)
        networkManager.getAllUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        studentsView.tableView.frame = view.bounds
    }
    
    private func setUpView() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - Extensions
extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentsTableViewCell.identifier, for: indexPath) as! StudentsTableViewCell
        cell.cellLabel.text = "\(students[indexPath.row].name) \(students[indexPath.row].surname)"
        if students[indexPath.row].locks.contains(lockId) {
            cell.indicator.image = UIImage(named: "granted")
        } else {
            cell.indicator.image = UIImage(named: "restricted")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        studentsView.spinner.show(in: self.view)
        if students[indexPath.row].locks.contains(lockId) {
            networkManager.manageAccessToLock(lockId: lockId, userId: students[indexPath.row].id, action: .remove)
        } else {
            networkManager.manageAccessToLock(lockId: lockId, userId: students[indexPath.row].id, action: .add)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension StudentsViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.studentsView.spinner.dismiss()
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverUsers(users: UsersModel) {
        DispatchQueue.main.async {
            self.studentsView.spinner.dismiss()
            self.students = users.users
            self.studentsView.tableView.reloadData()
        }
    }
}
