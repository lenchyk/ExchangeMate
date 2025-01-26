//
//  Currency.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 25.01.2025.
//

import Foundation

struct Currency: Decodable {
    var date: String
    var baseCurrency: String
    var quoteCurrency: String
    var quote: Double
}

extension Currency: Faking {
    init() {
        date = "2020-04-08"
        baseCurrency = "EUR"
        quoteCurrency = "CHF"
        quote = 1.0557
    }
}

extension Currency: Equatable {
    static func ==(_ lhs: Currency, _ rhs: Currency) -> Bool {
        lhs.date == rhs.date &&
        lhs.baseCurrency == rhs.baseCurrency &&
        lhs.quoteCurrency == rhs.quoteCurrency &&
        lhs.quote == rhs.quote
    }
}
