//
//  Currency+CoreDataClass.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//
//

import Foundation
import CoreData
import SwopAPI

@objc(Currency)
public class Currency: NSManagedObject {
    func update(remoteCurrency: LatestEuroQuery.Data.Latest) {
        self.date = remoteCurrency.date.lowercased()
        self.baseCurrency = remoteCurrency.baseCurrency
        self.quoteCurrency = remoteCurrency.quoteCurrency
        self.quote = remoteCurrency.quote
    }
    
    func toggleFavourite() {
        self.isFavourited = !self.isFavourited
    }
    
    var dateDescription: String {
        return date?.description ?? ""
    }
    
    var baseCurrencyDescription: String {
        return baseCurrency?.description ?? ""
    }
    
    var quoteCurrencyDescription: String {
        return quoteCurrency?.description ?? ""
    }
    
    var quoteDescription: String {
        return quote?.description ?? ""
    }
}

