//
//  CurrencyTableViewCell.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 25.01.2025.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    static let cellId = "CurrencyTableViewCell"
    @IBOutlet weak var baseQuoteLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var innerContentView: UIView!
    
    var cellCurrency: Currency?
    var likeButtonAction: (Currency) -> () = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerContentView.layer.cornerRadius = 20
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        baseQuoteLabel.text = ""
        currencyRateLabel.text = ""
        dateLabel.text = ""
        likeButton.setImage(nil, for: .normal)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        guard let currency = cellCurrency else {
            return
        }
        likeButtonAction(currency)
        changeLikeButtonUI(isFavourited: currency.isFavourited)
    }
    
    func setup(for currency: Currency, with likeAction: @escaping (Currency) -> ()) {
        cellCurrency = currency
        baseQuoteLabel.text = "\(currency.baseCurrencyDescription)/\(currency.quoteCurrencyDescription)"
        currencyRateLabel.text = "\(currency.quoteDescription)"
        dateLabel.text = currency.dateDescription
        likeButtonAction = likeAction
        changeLikeButtonUI(isFavourited: currency.isFavourited)
    }
    
    func changeLikeButtonUI(isFavourited: Bool) {
        let imageName = isFavourited ? Constants.Image.heartFilled : Constants.Image.heart
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
