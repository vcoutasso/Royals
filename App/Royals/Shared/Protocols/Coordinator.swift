//
//  Coordinator.swift
//  Royals
//
//  Created by Vinícius Couto on 03/09/21.
//

import UIKit

// Inspired from https://somevitalyz123.medium.com/coordinator-pattern-with-tab-bar-controller-33e08d39d7d
protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }

    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }

    var type: CoordinatorType { get }

    func start()
    func finish()

    init(navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

/// Delegate protocol helping parent Coordinator know when its child is ready to be finished.
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    case app, login, tab
}
