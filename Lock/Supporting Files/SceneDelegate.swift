//
//  SceneDelegate.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let navVc = UINavigationController(rootViewController: ClassRoomViewController())
        window.rootViewController = navVc
        window.makeKeyAndVisible()
        self.window = window
    }
}
