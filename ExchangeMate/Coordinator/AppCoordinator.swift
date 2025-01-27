//
//  AppCoordinator.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var rootViewController : TabBarController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var window: UIWindow?
    
    lazy var rootViewController: TabBarController = {
        let tabBarVC = TabBarController()
        return tabBarVC
    }()
    
    lazy var currenciesViewModel: CurrenciesViewModelProtocol = {
        let viewModel = CurrenciesViewModel()
        return viewModel
    }()
    
    lazy var favouritesViewModel: FavouritesViewModelProtocol = {
        let viewModel = FavouritesViewModel()
        return viewModel
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        setupTabs()
    }
    
    private func setupTabs() {
        guard let currenciesViewController = CurrenciesViewController.instantiate(from: .currencies) else {
            return
        }
        currenciesViewController.viewModel = currenciesViewModel
        
        guard let favouritesViewController = FavouritesViewController.instantiate(from: .favourites) else {
            return
        }
        favouritesViewController.viewModel = favouritesViewModel
        
        let currenciesNavigationController = createNavigationViewController(
            with: Constants.Storyboards.currencies.rawValue,
            systemImage: Constants.Image.eurosign,
            vc: currenciesViewController
        )
        
        let favouritesNavigationController = createNavigationViewController(
            with: Constants.Storyboards.favourites.rawValue,
            systemImage: Constants.Image.heart,
            vc: favouritesViewController
        )
        
        rootViewController.setViewControllers([currenciesNavigationController, favouritesNavigationController], animated: true)
    }
    
    private func createNavigationViewController(
        with title: String,
        systemImage: String,
        vc: UIViewController
    ) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: systemImage)
        
        navigationVC.viewControllers.first?.navigationItem.title = title
        return navigationVC
    }
}
