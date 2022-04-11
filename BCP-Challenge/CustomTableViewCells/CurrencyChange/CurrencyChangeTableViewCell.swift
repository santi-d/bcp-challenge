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
        guard let text = textField.text, let textRange = Range(range, in: text), let index = index  else {
            return false
        }

        let updatedText = text.replacingCharacters(in: textRange, with: string)
        let isEmptytext = updatedText.isEmpty

        let indexForRefreshing = [IndexPath(row: abs(1 - index), section: 0)]
        if isEmptytext {
            changeCurrencyDelegate?.onValueChanged(changedValue: "", calculatedValue: "", indexForRefreshing: indexForRefreshing)
            return true
        }

        guard let changedValue = Double(updatedText), let factor = pairCurrency?.changeValue else {
            return false
        }

        let calculatedValue = changedValue * factor

        if index == 0 {
            changeCurrencyDelegate?.onValueChanged(changedValue: "\(changedValue)", calculatedValue: "\(calculatedValue)", indexForRefreshing: indexForRefreshing)
        } else {
            changeCurrencyDelegate?.onValueChanged(changedValue: "\(calculatedValue)", calculatedValue: "\(changedValue)", indexForRefreshing: indexForRefreshing)
        }

        return true
    }
}
