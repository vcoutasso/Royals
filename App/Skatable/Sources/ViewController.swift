//
//  ViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 25/08/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Variables

    var tabBarViewController: UITabBarController!

    // Populated by `setupViewControllers`
    var tabBarItems: [TabBarItemVC] = []

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()

        setupTabBar()
    }

    override func viewDidAppear(_: Bool) {
        present(tabBarViewController, animated: false)
    }

    // MARK: - Private methods

    private func setupViewControllers() {
        tabBarItems.append(TabBarItemVC(viewController: MapViewController(), iconName: Strings.Icons.map))
    }

    private func setupTabBar() {
        tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers(tabBarItems.map { $0.viewController }, animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen

        guard let items = tabBarViewController.tabBar.items else { return }

        // TODO: Fill current item
        for idx in items.indices {
            items[idx].image = UIImage(systemName: tabBarItems[idx].iconName)
        }
    }

    // TODO: This probably belongs somewhere else.
    struct TabBarItemVC {
        let viewController: UIViewController
        let iconName: String
    }
}
