//
//  FavouritesViewModel.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import Foundation
import UIKit
import CoreData

protocol FavouritesViewModelProtocol {
    var favourites: [Currency] { get }
    var controllerActions: FavouritesControllerActions { get set }
    func toggleFavourite(currency: Currency)
    func fetchAndReloadFavourites()
}

// Actions to change/update UI
struct FavouritesControllerActions {
    var reloadFavourites: () -> () = {}
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    private enum Favourites {
        static let predicate = "isFavourited == TRUE"
    }
    
    private(set) var favourites: [Currency] = []
    var controllerActions: FavouritesControllerActions
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    init() {
        controllerActions = .init()
        fetchAndReloadFavourites()
    }
    
    deinit {
        print(Constants.Common.deinitMessage(String(describing: self)))
    }
    
    func fetchAndReloadFavourites() {
        guard let context else { return }
        do {
            let request = Currency.fetchRequest()
            request.predicate = NSPredicate(format: Favourites.predicate)
            favourites = try context.fetch(request)
            controllerActions.reloadFavourites()
        }
        catch {
            debugPrint(Constants.Error.favouritesFetch)
        }
    }
    
    func toggleFavourite(currency: Currency) {
        currency.toggleFavourite()
        saveContext()
        fetchAndReloadFavourites()
    }
    
    private func saveContext() {
        do {
            try context?.save()
        }
        catch {
           debugPrint(Constants.Error.saving)
        }
    }
}
