//
//  TabBarCoordinator.swift
//  Royals
//
//  Created by Vinícius Couto on 03/09/21.
//

import UIKit

protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    // MARK: - Public attributes

    weak var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController
    var tabBarController: UITabBarController = .init()

    var childCoordinators: [Coordinator] = []

    var type: CoordinatorType { .tab }

    // MARK: - Initialization

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Public methods

    func start() {
        let pages: [TabBarPage] = [.home, .map, .publish, .leaderboard, .profile]
            .sorted(by: { $0.pageIndex() < $1.pageIndex() })

        let controllers: [UINavigationController] = pages.map { getTabController($0) }

        prepareTabBarController(withTabControllers: controllers)
    }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageIndex()
    }

    // MARK: - Private methods

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)

        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.selectedIndex = TabBarPage.map.pageIndex()

        tabBarController.tabBar.barTintColor = Assets.Colors.darkSystemGray5.color
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = Assets.Colors.yellow.color
        tabBarController.tabBar.unselectedItemTintColor = Assets.Colors.darkGray.color

        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)

        let tabBarItem = UITabBarItem()
        tabBarItem.title = page.pageTitle()
        tabBarItem.image = UIImage(systemName: page.pageIconName())
        tabBarItem.selectedImage = UIImage(systemName: "\(page.pageIconName()).fill")
        tabBarItem.tag = page.pageIndex()

        navController.tabBarItem = tabBarItem

        switch page {
        case .home:
            let homeVC = WIPViewController()
            navController.pushViewController(homeVC, animated: true)
        case .map:
            let mapVC = MapViewController()
            navController.pushViewController(mapVC, animated: true)
        case .publish:
            let publishVC = WIPViewController()
            navController.pushViewController(publishVC, animated: true)
        case .leaderboard:
            let leaderboardVC = WIPViewController()
            navController.pushViewController(leaderboardVC, animated: true)
        case .profile:
            let profileVC = ProfileViewController()

            profileVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .logout:
                    self?.finish()
                }
            }

            navController.pushViewController(profileVC, animated: true)
        }

        return navController
    }
}

enum TabBarPage: Int {
    case home
    case map
    case publish
    case leaderboard
    case profile

    func pageIndex() -> Int {
        rawValue
    }

    func pageTitle() -> String {
        switch self {
        case .home:
            return Strings.Localizable.Tabbar.Home.title
        case .map:
            return Strings.Localizable.Tabbar.Map.title
        case .publish:
            return Strings.Localizable.Tabbar.Publish.title
        case .leaderboard:
            return Strings.Localizable.Tabbar.Leaderboard.title
        case .profile:
            return Strings.Localizable.Tabbar.Profile.title
        }
    }

    func pageIconName() -> String {
        switch self {
        case .home:
            return Strings.Names.Icons.home
        case .map:
            return Strings.Names.Icons.map
        case .publish:
            return Strings.Names.Icons.publish
        case .leaderboard:
            return Strings.Names.Icons.leaderboard
        case .profile:
            return Strings.Names.Icons.profile
        }
    }
}
