//
//  FavouritesViewModel.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var favourites: [Currency] { get }
    func removeFromFavourites(currency: Currency)
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    private(set) var favourites: [Currency]
    
    init() {
        favourites = []//[Currency.fakeItem()]
    }
    
    func removeFromFavourites(currency: Currency) {
        favourites.removeAll { $0 == currency }
    }
}
