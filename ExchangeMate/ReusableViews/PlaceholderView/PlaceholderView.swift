//
//  PlaceholderView.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import UIKit

class PlaceholderView: UIView {
    static let xibName = "PlaceholderView"
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit() {
        let nib = UINib(nibName: PlaceholderView.xibName, bundle: nil)
        if let xibView = nib.instantiate(withOwner: self).first as? UIView {
            addSubview(xibView)
            xibView.frame = bounds
        }
    }
    
    func setupUI(for storyboard: Constants.Storyboards) {
        switch storyboard {
        case .currencies:
            placeholderImageView.image = .oops
            placeholderLabel.text = Constants.Placeholder.Currencies.text
        case .favourites:
            placeholderImageView.image = .heart
            placeholderLabel.text = Constants.Placeholder.Favourites.text
        }
    }
}
