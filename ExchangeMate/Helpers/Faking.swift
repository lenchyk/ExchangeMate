//
//  Faking.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 25.01.2025.
//

import Foundation

protocol Faking {
    init()
    static func fakeItems(count: Int) -> [Self]
}

extension Faking {
    static func fakeItems(count: Int = 10) -> [Self] {
        (0..<count).map { _ in Self.init()}
    }
    
    static func fakeItem() -> Self {
        fakeItems(count: 1).first!
    }
}
