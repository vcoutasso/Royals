//
//  Coordinator.swift
//  Skatable
//
//  Created by Vinícius Couto on 03/09/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()

    init(navigationController: UINavigationController)
}
