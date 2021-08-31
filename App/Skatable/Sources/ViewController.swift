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
        tabBarItems
            .append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.home,
                                 title: Strings.Titles.home))
        tabBarItems
            .append(TabBarItemVC(viewController: MapViewController(), iconName: Strings.Icons.map,
                                 title: Strings.Titles.map))
        tabBarItems
            .append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.add,
                                 title: Strings.Titles.add))
        tabBarItems
            .append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.leaderboard,
                                 title: Strings.Titles.leaderboard))
        tabBarItems
            .append(TabBarItemVC(viewController: UIViewController(), iconName: Strings.Icons.profile,
                                 title: Strings.Titles.profile))
    }

    private func setupTabBar() {
        tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers(tabBarItems.map { $0.viewController }, animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.tabBar.unselectedItemTintColor = tabBarViewController.tabBar.tintColor

        guard let items = tabBarViewController.tabBar.items else { return }

        for idx in items.indices {
            items[idx].image = UIImage(systemName: tabBarItems[idx].iconName)
            items[idx].selectedImage = UIImage(systemName: "\(tabBarItems[idx].iconName).fill")
            items[idx].title = tabBarItems[idx].title
        }
    }

    // TODO: This probably belongs somewhere else.
    struct TabBarItemVC {
        let viewController: UIViewController
        let iconName: String
        let title: String
    }
}
