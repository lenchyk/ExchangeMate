//
//  CurrenciesCoordinator.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import UIKit

class CurrenciesCoordinator: Coordinator {
    var rootNavigationController: UINavigationController

    // MARK: VM / VC's
    lazy var currenciesViewModel: CurrenciesViewModelProtocol = {
        let viewModel = CurrenciesViewModel()
        viewModel.coordinator = self
        return viewModel
    }()

    // MARK: - Coordinator
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    override func start() {
        if let currenciesViewController = CurrenciesViewController.instantiate() {
            currenciesViewController.viewModel = currenciesViewModel
            rootNavigationController.setViewControllers([currenciesViewController], animated: false)
        }
    }

    override func finish() {
        removeAllChildCoordinators()
    }
}
