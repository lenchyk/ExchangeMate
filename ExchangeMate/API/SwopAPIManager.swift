//
//  SwopAPIManager.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import Foundation
import Apollo

class SwopAPIManager {
    private enum API {
        static let GRAPHQL_API_KEY = "GRAPHQL_API_KEY"
        static var endpoint: (String) -> String = { apiKey in
            return "https://swop.cx/graphql?api-key=\(apiKey)"
        }
    }
    static let shared = SwopAPIManager()

    var apollo: ApolloClient?

    init() {
        setupApolloClient()
    }
    
    private func setupApolloClient() {
        if let apiKey = ProcessInfo.processInfo.environment[API.GRAPHQL_API_KEY],
           let url = URL(string: API.endpoint(apiKey)) {
            apollo = ApolloClient(url: url)
        }
    }
}
