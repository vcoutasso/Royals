//
//  LoginCoordinator.swift
//  Skatable
//
//  Created by Vinícius Couto on 04/09/21.
//

import UIKit

final class LoginCoordinator: Coordinator {
    // MARK: - Public attributes

    var navigationController: UINavigationController
    var loginController: UIViewController = .init()

    var childCoordinators: [Coordinator] = []

    // MARK: - Initialization

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Public methods

    func start() {
        showLoginViewController()
    }

    // MARK: - Private methods

    private func showLoginViewController() {
        let loginVC: LoginViewController = .init()

        navigationController.pushViewController(loginVC, animated: true)
    }
}
