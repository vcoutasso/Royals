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

    override func viewDidAppear(_ animated: Bool) {
        present(tabBarViewController, animated: animated)
    }

    // MARK: - Private methods

    private func setupTabBarItems() {
        tabBarItems.append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.home))
        tabBarItems.append(TabBarItemVC(viewController: MapViewController(), iconName: Strings.Icons.map))
        tabBarItems.append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.add))
        tabBarItems.append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.leaderboard))
        tabBarItems.append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.profile))
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
