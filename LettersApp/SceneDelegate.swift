//
//  SceneDelegate.swift
//  LettersApp
//
//  Created by Алексей Орловский on 11.08.2023.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // create object realm login stage
        let realm = try? Realm()
        if (realm?.objects(RealmLoginModel.self).first) != nil {
            NavigationManager.shared.showAuthUserStage()
        } else {
            NavigationManager.shared.showNotAuthUserStage()
        }
    }
}

