//
//  Currency+CoreDataProperties.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var date: String?
    @NSManaged public var baseCurrency: String?
    @NSManaged public var quoteCurrency: String?
    @NSManaged public var quote: String?
    @NSManaged public var isFavourited: Bool
}

extension Currency : Identifiable {

}
