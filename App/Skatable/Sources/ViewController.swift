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
    var tabBarItems: [TabBarItem] = []

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
            .append(TabBarItem(viewController: UIViewController(), iconName: Strings.Names.Icons.home,
                               title: Strings.Localizable.Tabbar.Home.title))
        tabBarItems
            .append(TabBarItem(viewController: MapViewController(), iconName: Strings.Names.Icons.map,
                               title: Strings.Localizable.Tabbar.Map.title))
        tabBarItems
            .append(TabBarItem(viewController: UIViewController(), iconName: Strings.Names.Icons.add,
                               title: Strings.Localizable.Tabbar.Add.title))
        tabBarItems
            .append(TabBarItem(viewController: UIViewController(), iconName: Strings.Names.Icons.leaderboard,
                               title: Strings.Localizable.Tabbar.Leaderboard.title))
        tabBarItems
            .append(TabBarItem(viewController: UIViewController(), iconName: Strings.Names.Icons.profile,
                               title: Strings.Localizable.Tabbar.Profile.title))
    }

    private func setupTabBar() {
        tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers(tabBarItems.map { $0.viewController }, animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.tabBar.tintColor = Assets.Colors.yellow.color

        guard let items = tabBarViewController.tabBar.items else { return }

        for idx in items.indices {
            items[idx].image = UIImage(systemName: tabBarItems[idx].iconName)
            items[idx].selectedImage = UIImage(systemName: "\(tabBarItems[idx].iconName).fill")
            items[idx].title = tabBarItems[idx].title
        }
    }

    // TODO: This probably belongs somewhere else.
    struct TabBarItem {
        let viewController: UIViewController
        let iconName: String
        let title: String
    }
}
