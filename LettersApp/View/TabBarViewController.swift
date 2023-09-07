//
//  TabBarViewController.swift
//  LettersApp
//
//  Created by Алексей Орловский on 14.08.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupTabBar()
    }
    
    func setupTabBar() {
        viewControllers = [
            UINavigationController(rootViewController: showViewController(viewController: LettersViewController(), title: "Letters", image: UIImage(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")!)),
            UINavigationController(rootViewController: showViewController(viewController: AccountViewController(), title: "Account", image: UIImage(systemName: "person.fill")!)),
        ]
    }
    
    /// edit demonstration ViewControllers
    private func showViewController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        return viewController
    }
}
