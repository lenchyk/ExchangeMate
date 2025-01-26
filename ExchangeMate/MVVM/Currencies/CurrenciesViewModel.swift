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
        // TODO: - check for network connection and fetch from local storage if needed
        SwopAPIManager.shared.apollo.fetch(query: LatestEuroQuery()) { [weak self] result in
            switch result {
            case .success(let result):
                guard let data = result.data?.latest, let context = self?.context else {
                    debugPrint("Error! Data or context can be nil!")
                    return
                }
                for remote in data {
                    let currency = Currency(context: context)
                    currency.update(remoteCurrency: remote)
                    self?.saveContext()
                    //self?.currencies.append(currency)
                }
            case .failure(let error):
                // TODO: - Show alert for user (better UX)
                debugPrint("Failure! Error: \(error)")
                // maybe fetch the local data in here?
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
            debugPrint("Error >>> while fetching Currencies!")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        }
        catch {
           debugPrint("Error >>> while saving the Favourite!")
        }
    }
}
