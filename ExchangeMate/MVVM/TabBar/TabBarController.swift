//
//  TabBarController.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white.withAlphaComponent(0.95)
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .darkGray
    }
}
