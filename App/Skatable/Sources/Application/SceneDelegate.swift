//
//  SceneDelegate.swift
//  Skatable
//
//  Created by Vinícius Couto on 25/08/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo _: UISceneSession,
               options _: UIScene.ConnectionOptions) {
        // Manually configure and attach the UIWindow `window` to the provided UIWindowScene `scene`
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navController = UINavigationController()

        appCoordinator = .init(navigationController: navController)
        appCoordinator?.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }
}
