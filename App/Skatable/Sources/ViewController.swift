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

    // Populated by `setupTabBarItems`
    var tabBarItems: [TabBarItemVC] = []

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItems()

        setupTabBar()
    }

    override func viewDidAppear(_: Bool) {
        present(tabBarViewController, animated: false)
    }

    // MARK: - Private methods

    private func setupTabBarItems() {
        tabBarItems.append(TabBarItemVC(viewController: MapViewController(), iconName: Strings.Icons.map))
    }

    private func setupTabBar() {
        tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers(tabBarItems.map { $0.viewController }, animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen

        guard let items = tabBarViewController.tabBar.items else { return }

        for idx in items.indices {
            if #available(iOS 13.0, *) {
                // TODO: Fill current item
                items[idx].image = UIImage(systemName: tabBarItems[idx].iconName)
            } else {
                // TODO: Set custom icons for ios 12 etc
            }
        }
    }

    // TODO: This probably belongs somewhere else.
    struct TabBarItemVC {
        let viewController: UIViewController
        let iconName: String
    }
}
