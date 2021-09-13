//
//  LoginCoordinator.swift
//  Royals
//
//  Created by Vinícius Couto on 04/09/21.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    // MARK: - Public attributes

    weak var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController
    var loginController: UIViewController = .init()

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType { .login }

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

    func showLoginViewController() {
        let loginVC: LoginViewController = .init()
        loginVC.didSendEventClosure = { [weak self] _ in
            self?.finish()
        }
        navigationController.pushViewController(loginVC, animated: true)
    }
}
