//
//  SceneDelegate.swift
//  Skatable
//
//  Created by Vinícius Couto on 25/08/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Manually configure and attach the UIWindow `window` to the provided UIWindowScene `scene`
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .dark
        self.window = window
    }
}
