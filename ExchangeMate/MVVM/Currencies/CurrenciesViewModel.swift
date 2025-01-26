//
//  CurrenciesViewModel.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import Foundation
import SwopAPI

protocol CurrenciesViewModelProtocol {
    var currencies: [Currency] { get }
    var controllerActions: CurrenciesControllerActions { get set }
}

// Actions to change/update UI
struct CurrenciesControllerActions {
    var reloadCurrencies: () -> () = {}
}

class CurrenciesViewModel: CurrenciesViewModelProtocol {
    var currencies: [Currency] = []
    var controllerActions: CurrenciesControllerActions
    
    init() {
        controllerActions = .init()
        fetchCurrencies()
    }
    
    deinit {
        print(Constants.Common.deinitMessage(String(describing: self)))
    }
    
    private func fetchCurrencies() {
        SwopAPIManager.shared.apollo.fetch(query: LatestEuroQuery()) { [weak self] result in
            switch result {
            case .success(let result):
                guard let data = result.data?.latest else { return }
                for currency in data {
                    self?.currencies.append(.init(remoteCurrency: currency))
                }
                self?.controllerActions.reloadCurrencies()
            case .failure(let error):
                // TODO: - Show alert for user (better UX)
                debugPrint("Failure! Error: \(error)")
            }
        }
    }
}
