//
//  NavigationManager.swift
//  LettersApp
//
//  Created by Алексей Орловский on 12.08.2023.
//

import UIKit

class NavigationManager {
    static let shared = NavigationManager()
    
    func showAuthUserStage() {
        
        let viewController = TabBarViewController()
        
        let navigationController = viewController
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
        
        
    }
    
    func showNotAuthUserStage() {
        
        let viewController = WelcomeViewController()
        
        let navigationController = viewController
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
