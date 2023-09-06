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
        // Создание окна и установка корневого контроллера
        let realm = try? Realm()
        if let user = realm?.objects(RealmLoginModel.self).first {
            NavigationManager.shared.showAuthUserStage()
        } else {
            NavigationManager.shared.showNotAuthUserStage()
        }
    }
}

