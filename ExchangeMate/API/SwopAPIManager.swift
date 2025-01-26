//
//  SwopAPIManager.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import Foundation
import Apollo

class SwopAPIManager {
    static let shared = SwopAPIManager()

    let apollo: ApolloClient

    init() {
        apollo = ApolloClient(url: URL(string: "https://swop.cx/graphql?api-key=785d80f4d041f140e37aa8b0ebf958f964a6c5a29d0415c22a93794c8043d0f4")!)
    }
}
