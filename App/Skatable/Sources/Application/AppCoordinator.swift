//
//  AppCoordinator.swift
//  Skatable
//
//  Created by Vinícius Couto on 03/09/21.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

final class AppCoordinator: AppCoordinatorProtocol {
    // MARK: - Public attributes

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    // MARK: - Initialization

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Public methods

    func start() {
        showLoginFlow()
    }

    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
//        showMainFlow()
    }

    func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}
