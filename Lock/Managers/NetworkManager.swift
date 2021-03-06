//
//  NetworkManager.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func errorOccurred(_ error: Error)
    func signIn()
    func deliverLocks(locks: [LockModel])
    func deliverLockInfo(lockInfo: LockInfo)
    func deliverUsers(users: UsersModel)
}

final class NetworkManager {
    
    // MARK: - Properties
    weak var delegate: NetworkManagerDelegate?
    
    // MARK: - Functions
    func register(email: String, password: String, name: String, surname: String) {
        
        let url = URL(string: Constants.baseAPIUrl + "auth/registration")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email": email,
            "password": password,
            "name": name,
            "surname": surname
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = bodyData
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthModel.self, from: data)
                self.cacheToken(token: result.token)
                self.getUserInfo()
            } catch {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
        }
        task.resume()
    }
    
    func logIn(email: String, password: String) {
        
        let url = URL(string: Constants.baseAPIUrl + "auth/login")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email": email,
            "password": password
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = bodyData
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthModel.self, from: data)
                self.cacheToken(token: result.token)
                self.getUserInfo()
                
            } catch {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
        }
        task.resume()
    }
    
    func fetchLocks() {
        
        let url = URL(string: Constants.baseAPIUrl + "locks")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = UserDefaults.standard.string(forKey: Constants.accessToken) else {
            delegate?.errorOccurred(NetworkErrors.noToken)
            return
        }
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(LocksModel.self, from: data)
                self.delegate?.deliverLocks(locks: result.locks)
            } catch {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
        }
        task.resume()
    }
    
    func getLockInfo(lockId: Int) {
        let url = URL(string: Constants.baseAPIUrl + "locks/\(lockId)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = UserDefaults.standard.string(forKey: Constants.accessToken) else {
            delegate?.errorOccurred(NetworkErrors.noToken)
            return
        }
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(LockInfo.self, from: data)
                self.delegate?.deliverLockInfo(lockInfo: result)
            } catch {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
        }
        task.resume()
    }
    
    func getUserInfo() {
        let url = URL(string: Constants.baseAPIUrl + "users/info")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = UserDefaults.standard.string(forKey: Constants.accessToken) else {
            delegate?.errorOccurred(NetworkErrors.noToken)
            return
        }
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserInfo.self, from: data)
                if result.is_admin {
                    UserDefaults.standard.set(true, forKey: Constants.isAdmin)
                }
                self.delegate?.signIn()
            } catch {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
        }
        task.resume()
    }
    
    func getAllUsers() {
        let url = URL(string: Constants.baseAPIUrl + "users")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = UserDefaults.standard.string(forKey: Constants.accessToken) else {
            delegate?.errorOccurred(NetworkErrors.noToken)
            return
        }
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UsersModel.self, from: data)
                self.delegate?.deliverUsers(users: result)
            } catch {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
        }
        task.resume()
    }
    
    func manageAccessToLock(lockId: Int, userId: Int, action: Constants.AccessAction) {
        
        var url: URL
        
        switch action {
        case .add:
            url = URL(string: Constants.baseAPIUrl + "locks/" + "\(lockId)/" + "add_user")!
        case .remove:
            url = URL(string: Constants.baseAPIUrl + "locks/" + "\(lockId)/" + "remove_user")!
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = UserDefaults.standard.string(forKey: Constants.accessToken) else {
            delegate?.errorOccurred(NetworkErrors.noToken)
            return
        }
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let body = [
            "id": userId
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = bodyData
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] _, response, error in
            guard let self = self, error == nil else {
                self?.delegate?.errorOccurred(NetworkErrors.noConnection)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                self.getAllUsers()
            } else {
                self.delegate?.errorOccurred(NetworkErrors.noData)
            }
            
        }
        task.resume()
    }
    
    private func cacheToken(token: String) {
        UserDefaults.standard.set(token, forKey: Constants.accessToken)
    }
}

// MARK: - Extensions
extension NetworkManagerDelegate {
    func signIn() {
        
    }
    
    func deliverLocks(locks: [LockModel]) {
        
    }
    
    func deliverLockInfo(lockInfo: LockInfo) {
        
    }
    
    func deliverUsers(users: UsersModel) {
        
    }
}
