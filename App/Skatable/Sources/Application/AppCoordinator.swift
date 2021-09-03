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

class AppCoordinator: AppCoordinatorProtocol {
    // MARK: - Public attributes

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Public methods

    func start() {
        showLoginFlow()
    }

    func showLoginFlow() {
        // TODO: Show ogin scene until user logs in
        showMainFlow()
    }

    func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}
