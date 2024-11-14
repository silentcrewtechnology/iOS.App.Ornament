//
//  SceneDelegate.swift
//  AbbDesignTestApp
//
//  Created by Алексей Титов on 30.10.2022.
//

import UIKit
import FontService
import Router

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var mainCoordinator = MainCoordinator(
        componentsShowcaseCoordinator: ComponentsShowcaseCoordinator(
            routerService: .init(),
            componentsShowcaseFeature: .init()
        )
    )

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        FontService.registerFonts()
        window = UIWindow(windowScene: windowScene)
        mainCoordinator.setupCoordinatorsFlow()
        mainCoordinator.setRoot()
    }
}
