//
//  AppCoordinator.swift
//  Royals
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

    weak var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    var type: CoordinatorType { .app }

    // MARK: - Initialization

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Public methods

    func start() {
        if retrieveUserCredentials() != nil {
            showMainFlow()
        } else {
            UserDefaults.standard.set("vcoutasso", forKey: Strings.Names.Keys.uid)
            showLoginFlow()
        }
    }

    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }

    func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }

        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()

            showMainFlow()
        case .tab:
            navigationController.viewControllers.removeAll()

            showLoginFlow()
        default:
            break
        }
    }
}
