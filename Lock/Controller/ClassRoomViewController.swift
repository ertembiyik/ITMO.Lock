//
//  ClassRoomViewController.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit
import SDWebImage

class ClassRoomViewController: UIViewController {

    // MARK: - Properties
    let networkManager = NetworkManager()
    
    let classRoomView = ClassRoomView()
    
    private let lock: LockModel
    
    private let lockInfo: LockInfo
    
    // MARK: - Lifecycle
    init(lock: LockModel) {
        self.lock = lock
        self.lockInfo = LockInfo(token: "", mac: "")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = classRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavVar()
        networkManager.delegate = self
        classRoomView.spinner.show(in: self.view, animated: true, afterDelay: 2)
        networkManager.getLockInfo(lockId: lock.id)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        classRoomView.classImageView.layer.cornerRadius = classRoomView.classImageView.frame.size.width / 2
    }
    
    // MARK: - Functions
    private func setNavVar() {
        title = "Аудитория \(lock.number)"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        if UserDefaults.standard.bool(forKey: Constants.isAdmin) {
            classRoomView.studentsButton.addTarget(self, action: #selector(studentsButtonDidTapped), for: .touchUpInside)
            let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem()
            rightBarButtonItem.customView = classRoomView.studentsButton
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    @objc private func studentsButtonDidTapped() {
        let vc = StudentsViewController(lockId: lock.id)
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extensions
extension ClassRoomViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.classRoomView.spinner.dismiss()
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverLockInfo(lockInfo: LockInfo) {
        DispatchQueue.main.async {
            self.classRoomView.spinner.dismiss()
            self.classRoomView.classImageView.sd_setImage(with: URL(string: self.lock.preview)!)
        }
    }
}
