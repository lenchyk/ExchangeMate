//
//  Storyboardable.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 24.01.2025.
//

import UIKit

protocol Storyboardable {
    static func instantiate(from storyboard: Constants.Storyboards) -> Self?
}

extension Storyboardable where Self: UIViewController {
    static func instantiate(from storyboard: Constants.Storyboards) -> Self? {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as? Self
    }
}
