//
//  Constants.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 24.01.2025.
//

import Foundation

enum Constants {
    enum Common {
        static var deinitMessage: (String) -> String = { className in
            return "Here \(className) deinited!"
        }
    }
    
    enum Storyboards: String {
        case currencies = "Currencies"
        case favourites = "Favourites"
    }
    
    enum Image {
        static let heart = "heart"
        static let heartFilled = "heart.fill"
        static let eurosign = "eurosign"
    }
    
    enum Placeholder {
        enum Currencies {
            static let text = "You have some trouble with connection or there has been some error! Try again later, please."
        }
        
        enum Favourites {
            static let text = "You have not added any favourite currencies yet."
        }
    }
}
