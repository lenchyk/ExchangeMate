//
//  CurrenciesViewModel.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import Foundation
import SwopAPI
import UIKit
import CoreData

protocol CurrenciesViewModelProtocol {
    var currencies: [Currency] { get }
    var controllerActions: CurrenciesControllerActions { get set }
    func toggleFavourite(currency: Currency)
    func fetchAndReloadLocalCurrencies()
}

// Actions to change/update UI
struct CurrenciesControllerActions {
    var reloadCurrencies: () -> () = {}
}

class CurrenciesViewModel: CurrenciesViewModelProtocol {
    var currencies: [Currency] = []
    var controllerActions: CurrenciesControllerActions
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                guard let data = result.data?.latest, let context = self?.context else {
                    debugPrint(Constants.Error.networkFetch)
                    return
                }
                for remote in data {
                    let currency = Currency(context: context)
                    currency.update(remoteCurrency: remote)
                    self?.saveContext()
                }
            case .failure(let error):
                debugPrint(Constants.Error.universal(error.localizedDescription))
            }
        }
        fetchAndReloadLocalCurrencies()
    }
    
    func toggleFavourite(currency: Currency) {
        currency.toggleFavourite()
        saveContext()
        fetchAndReloadLocalCurrencies()
    }
    
    func fetchAndReloadLocalCurrencies() {
        do {
            currencies = try context.fetch(Currency.fetchRequest())
            controllerActions.reloadCurrencies()
        }
        catch {
            debugPrint(Constants.Error.currenciesFetch)
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        }
        catch {
            debugPrint(Constants.Error.saving)
        }
    }
}
