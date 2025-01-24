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
    var navigationController : UINavigationController { get set }
    
    func start()
    // func finish()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var window: UIWindow?
    
    lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    lazy var currenciesViewModel: CurrenciesViewModelProtocol = {
        let viewModel = CurrenciesViewModel()
        viewModel.coordinator = self
        return viewModel
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        debugPrint("Starting App Coordinator")
        guard let window = window else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        goToCurrencies()
    }
    
    private func goToCurrencies() {
        if let currenciesViewController = CurrenciesViewController.instantiate(from: .currencies) {
            currenciesViewController.viewModel = currenciesViewModel
            navigationController.setViewControllers([currenciesViewController], animated: false)
        }
    }
}
