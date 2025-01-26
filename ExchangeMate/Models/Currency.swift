//
//  Currency.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 25.01.2025.
//

import Foundation
import SwopAPI

struct Currency {
    var date: String
    var baseCurrency: String
    var quoteCurrency: String
    var quote: String
    var isFavourited: Bool = false
    
    init(remoteCurrency: LatestEuroQuery.Data.Latest) {
        date = remoteCurrency.date.lowercased()
        baseCurrency = remoteCurrency.baseCurrency
        quoteCurrency = remoteCurrency.quoteCurrency
        quote = remoteCurrency.quote
    }
}

extension Currency: Faking {
    init() {
        date = "2020-04-08"
        baseCurrency = "EUR"
        quoteCurrency = "CHF"
        quote = "1.23993"
    }
}

extension Currency: Equatable {
    static func ==(_ lhs: Currency, _ rhs: Currency) -> Bool {
        lhs.date == rhs.date &&
        lhs.baseCurrency == rhs.baseCurrency &&
        lhs.quoteCurrency == rhs.quoteCurrency
    }
}
