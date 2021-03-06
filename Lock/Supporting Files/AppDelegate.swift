//
//  AppDelegate.swift
//  Lock
//
//  Created by Ertem Biyik on 30.09.2021.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import TTLock

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var restrictRotation: UIInterfaceOrientationMask = .portrait

    let keyboardManager = IQKeyboardManager.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserDefaults.standard.string(forKey: Constants.accessToken) != nil {
            let vc = LocksTableViewController()
            let navVc = UINavigationController(rootViewController: vc)
            window.rootViewController = navVc
        } else {
            let vc = LogInViewController()
            window.rootViewController = vc
        }
        
        keyboardManager.enable = true
        
        keyboardManager.shouldResignOnTouchOutside = true
        
        keyboardManager.shouldShowToolbarPlaceholder = false
        
        keyboardManager.enableAutoToolbar = true
        
        SDImageCache.shared.config.shouldCacheImagesInMemory = true
        
        TTLock.setupBluetooth({ state in
            print("TTLock is working, bluetooth state: \(state)")
        })
        
        UINavigationBar.appearance().tintColor = .white
        window.makeKeyAndVisible()
        self.window = window

        return true
    }

    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.restrictRotation
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
