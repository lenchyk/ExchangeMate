//
//  CurrenciesViewModel.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import Foundation

protocol CurrenciesViewModelProtocol {
    var currencies: [Currency] { get }
}

class CurrenciesViewModel: CurrenciesViewModelProtocol {
    var currencies: [Currency]
    
    init() {
        currencies = Currency.fakeItems(count: 10)
    }
}
