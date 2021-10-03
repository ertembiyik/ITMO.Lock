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
        title = "Аудитория \(lock.number)"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        classRoomView.classImageView.isHidden = true
        classRoomView.descriptionLabel.isHidden = true
        classRoomView.openTheDoorButton.isHidden = true
        networkManager.delegate = self
        networkManager.getLockInfo(lockId: "1")
        classRoomView.spinner.show(in: self.view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        classRoomView.classImageView.layer.cornerRadius = classRoomView.classImageView.frame.size.width / 2
    }
}

extension ClassRoomViewController: NetworkManagerDelegate {
    func errorOccurred(_ error: Error) {
        DispatchQueue.main.async {
            self.classRoomView.spinner.dismiss()
            self.showAlert(with: "Ошибка", message: error.localizedDescription, style: .alert)
        }
    }
    
    func deliverLockInfo(lockInfo: LockInfo) {
        DispatchQueue.main.async {
            self.classRoomView.spinner.dismiss(afterDelay: 0, animated: true) {
                self.classRoomView.classImageView.isHidden = false
                self.classRoomView.descriptionLabel.isHidden = false
                self.classRoomView.openTheDoorButton.isHidden = false
                
                self.classRoomView.classImageView.sd_setImage(with: URL(string: self.lock.preview)!)
            }
        }
    }
}
