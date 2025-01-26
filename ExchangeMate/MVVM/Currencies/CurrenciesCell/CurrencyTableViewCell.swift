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
    
    var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerContentView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        isLiked = !isLiked
        changeLikeButtonUI()
        // add to local storage
    }
    
    func setupUI(for currency: Currency) {
        baseQuoteLabel.text = "\(currency.baseCurrency)/\(currency.quoteCurrency)"
        currencyRateLabel.text = "\(currency.quote)"
        dateLabel.text = currency.date
    }
    
    func changeLikeButtonUI() {
        let imageName = isLiked ? Constants.Image.heartFilled : Constants.Image.heart
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
