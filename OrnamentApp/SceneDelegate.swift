//
//  SceneDelegate.swift
//  AbbDesignTestApp
//
//  Created by Алексей Титов on 30.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigation = UINavigationController()
        
        let coordinator = MainScreenCoordinator(navigation: navigation)
        let builder = MainBuilder(coordinator: coordinator)
        navigation.setViewControllers([builder.view], animated: true)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
