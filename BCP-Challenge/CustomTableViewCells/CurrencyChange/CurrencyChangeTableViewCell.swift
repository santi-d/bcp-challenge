//
//  CurrencyChangeTableViewCell.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import UIKit

class CurrencyChangeTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var inputTextField: UITextField!
    @IBOutlet weak private var currencyLabel: UILabel!
    @IBOutlet weak private var currencyLabelContainerView: UIView!
    private var pairCurrency: PairCurrency?

    var index: Int?
    weak var changeCurrencyDelegate: ChangeCurrencyDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupBehaviors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
        setupBehaviors()
    }

    // MARK: - private functions

    private func setupView() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.bcpLightGray.cgColor

        // titleLabel
        titleLabel.textColor = UIColor.bcpGray
        titleLabel.font = .bcpMedium(size: 15.0)

        // inputTextField
        inputTextField.textColor = .black
        inputTextField.font = .bcpMedium(size: 15.0)
        inputTextField.borderStyle = .none
        inputTextField.keyboardType = .decimalPad

        // other setups
        currencyLabel.textColor = .white
        currencyLabel.font = .bcpBold(size: 15.0)

        setupCurrencyLabelContainerView()
    }

    private func setupBehaviors() {
        inputTextField.delegate = self
    }

    // MARK: -- other setups

    private func setupCurrencyLabelContainerView() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressOverCurrencyLabelContainerView))
        longPressGesture.minimumPressDuration = 3
        longPressGesture.delaysTouchesBegan = true

        currencyLabelContainerView.addGestureRecognizer(longPressGesture)

        currencyLabelContainerView.backgroundColor = .bcpMetallicBlue
    }

    @objc private func longPressOverCurrencyLabelContainerView(sender: UILongPressGestureRecognizer) {
        if sender.state == .began, let selectedIndex = index {
            changeCurrencyDelegate?.presentOtherCurrenciesScreen(withDataFromIndex: selectedIndex)
        }
    }

    // MARK: - public functions

    func setupCell(inputValue: String, pairCurrency: PairCurrency, index: Int, delegate: ChangeCurrencyDelegate) {
        self.pairCurrency = pairCurrency
        titleLabel.text = index == 0 ? "Tu envias:" : "Tu recibes:"
        currencyLabel.text = pairCurrency.origin.value
        changeCurrencyDelegate = delegate
        inputTextField.text = inputValue
        self.index = index
    }
}

extension CurrencyChangeTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text), let index = index {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            let isEmptytext = updatedText.isEmpty

            if isEmptytext {
                changeCurrencyDelegate?.onEnteredValue(value: 0.0, onCellRow: index)
                return true
            }

            if let doubleValue = Double(updatedText) {
                changeCurrencyDelegate?.onEnteredValue(value: doubleValue, onCellRow: index)
            }

            return true
        }

        return false
    }
}
