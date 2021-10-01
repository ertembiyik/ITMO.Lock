//
//  NetworkManager.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func errorOccurred(_ error: Error)
    func deliverToken(_ token: String)
}

final class NetworkManager {

    // MARK: - Properties
    weak var delegate: NetworkManagerDelegate?

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
                self.delegate?.deliverToken(result.token)
            } catch {
                self.delegate?.errorOccurred(error)
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
                self.delegate?.deliverToken(result.token)
            } catch {
                self.delegate?.errorOccurred(error)
            }
        }
        task.resume()
    }
}
