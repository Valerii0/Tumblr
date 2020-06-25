//
//  MainCoordinator.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

protocol Coordinatable {
    var tabBarController: UITabBarController { get set }
    var taggedRouter: Routable { get set }
    var favouritesRouter: Routable { get set }
}

final class MainCoordinator: Coordinatable {
    var window: UIWindow
    var tabBarController: UITabBarController
    var taggedRouter: Routable
    var favouritesRouter: Routable

    private enum StoryboardsName: String {
        case tabTagged = "Tagged"
    }
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.tabBarController = UITabBarController()
        self.tabBarController.tabBar.barTintColor = UIColor(red: 0/255.0, green: 25/255.0, blue: 53/255.0, alpha: 1)
        self.tabBarController.tabBar.tintColor = .white
        self.taggedRouter = RouterType.tagged.router
        self.taggedRouter.navigationController.navigationBar.isHidden = true
        self.favouritesRouter = RouterType.favourites.router
        self.favouritesRouter.navigationController.navigationBar.isHidden = true
    }
    
    func configure() {
        makeTabBarRoot()
    }
    
    func makeTabBarRoot() {
        window.rootViewController = tabBarController
        tabBarController.viewControllers = [
            searchViewController(),
            favouritesViewController()
        ]
        tabBarController.selectedIndex = 0
    }
    
    func searchViewController() -> UINavigationController {
        let viewController = TaggedViewController.instantiate(storyboardName: StoryboardsName.tabTagged.rawValue)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let configurator = TaggedConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, taggedState: .search)
        taggedRouter.navigationController.viewControllers = [viewController]
        return taggedRouter.navigationController
    }
    
    func presentDetailedViewControllerSearch(delegate: AddDeleteDelegate?, isPostAdded: Bool, post: Post) {
        let viewController = DetailedViewController.instantiate(storyboardName: StoryboardsName.tabTagged.rawValue)
        let configurator = DetailedConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, delegate: delegate, isPostAdded: isPostAdded, post: post)
        taggedRouter.present(controller: viewController, animated: true)
    }
    
    func favouritesViewController() -> UINavigationController {
        let viewController = TaggedViewController.instantiate(storyboardName: StoryboardsName.tabTagged.rawValue)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let configurator = TaggedConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, taggedState: .favourites)
        favouritesRouter.navigationController.viewControllers = [viewController]
        return favouritesRouter.navigationController
    }
    
    func presentDetailedViewControllerFavourites(delegate: AddDeleteDelegate?, isPostAdded: Bool, post: Post) {
        let viewController = DetailedViewController.instantiate(storyboardName: StoryboardsName.tabTagged.rawValue)
        let configurator = DetailedConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, delegate: delegate, isPostAdded: isPostAdded, post: post)
        favouritesRouter.present(controller: viewController, animated: true)
    }
}
