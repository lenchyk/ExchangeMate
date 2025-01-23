//
//  CurrenciesViewController.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import UIKit

class CurrenciesViewController: UIViewController {
    var viewModel: CurrenciesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CurrenciesViewController {
    static func instantiate() -> CurrenciesViewController? {
        return UIStoryboard(name: "Currencies", bundle: nil).instantiateViewController(withIdentifier: "CurrenciesViewController") as? CurrenciesViewController
    }
}

