//
//  ClassRoomsTableViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit

class LocksTableViewController: UIViewController {

    // MARK: - Properties
    private let networkManager = NetworkManager()
    
    private let locksTableView = LocksTableView()
    
    private var locks = [LockModel]()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = locksTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Аудитории"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        networkManager.delegate = self
        networkManager.fetchLocks()
        locksTableView.tableView.delegate = self
        locksTableView.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        locksTableView.tableView.frame = view.bounds
    }
}

extension LocksTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocksTableViewCell.identifier, for: indexPath) as! LocksTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = Constants.themeBackGroundColor
        cell.cellLabel.text = "\(locks[indexPath.row].number)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lock = locks[indexPath.row]
        let vc = ClassRoomViewController(lock: lock)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension LocksTableViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverLocks(locks: [LockModel]) {
        DispatchQueue.main.async {
            self.locks = locks
            self.locksTableView.tableView.reloadData()
        }
    }
    
}
