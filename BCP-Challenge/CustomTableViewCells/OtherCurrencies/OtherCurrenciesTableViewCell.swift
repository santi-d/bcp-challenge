//
//  OtherCurrenciesTableViewCell.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import UIKit

class OtherCurrenciesTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupView()
    }

    // MARK: - private functions

    private func setupView() {
        countryLabel.font = .bcpBold(size: 15.0)
        countryLabel.textColor = .bcpGray

        currencyLabel.font = .bcpMedium(size: 15.0)
        currencyLabel.textColor = .bcpLightGray
    }

    // MARK: - public functions

    func setupCell(pairCurrency: PairCurrency) {
        flagImageView.image = UIImage(named: pairCurrency.destination.rawValue)
        countryLabel.text = pairCurrency.destination.country
        currencyLabel.text = pairCurrency.message
    }
}
