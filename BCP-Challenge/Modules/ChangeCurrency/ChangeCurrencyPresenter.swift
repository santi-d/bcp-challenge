//
//  ChangeCurrencyPresenter.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import Foundation


typealias TuplePairCurrency = (firstPairCurrency: PairCurrency, secondPairCurrency: PairCurrency)

protocol ChangeCurrencyPresenterProtocol {
    var interactor: ChangeCurrencyInteractorProtocol? { get set }
    var dataSource: [PairCurrency] { get }
    var valueDataSource: [String] { get set }
    var selectedCurrencyIndex: Int? { get set }
    var buySellMessage: String { get }

    func updateDataSource(element: TuplePairCurrency)
    func reverseCurrencies()
    func startOperation()
    func resetValueDataSource()
}

class ChangeCurrencyPresenter: ChangeCurrencyPresenterProtocol {
    private var firstPairCurrency: PairCurrency?
    private var secondPairCurrency: PairCurrency?

    var interactor: ChangeCurrencyInteractorProtocol? = ChangeCurrencyInteractor()
    var dataSource: [PairCurrency] = []
    // TODO: Improve using vm
    var valueDataSource: [String] = []

    var buySellMessage: String {
        let buyValue = firstPairCurrency?.changeValue ?? 0.00
        let sellValue = secondPairCurrency?.changeValue ?? 0.00

        return String(format: "Compra: %.2f | Venta: %.2f", 1.0 / buyValue, sellValue)
    }
    
    var selectedCurrencyIndex: Int?

    init() {
        guard let firstPair = interactor?.fetchDefaultPairCurrency() else { return }
        guard let secondPair = interactor?.getReversePairCurrency(from: firstPair)  else { return }

        firstPairCurrency = firstPair
        secondPairCurrency = secondPair

        dataSource = [firstPair, secondPair]
        resetValueDataSource()
    }

    func updateDataSource(element: TuplePairCurrency) {
        firstPairCurrency = element.firstPairCurrency
        secondPairCurrency = element.secondPairCurrency 
        dataSource = [element.firstPairCurrency, element.secondPairCurrency]

        if selectedCurrencyIndex == 1 {
            dataSource.reverse()
        }
        selectedCurrencyIndex = nil
    }

    func reverseCurrencies() {
        dataSource.reverse()
    }

    func startOperation() {
        // TODO: Using router navigate to other screen
    }

    func resetValueDataSource() {
        valueDataSource = ["", ""]
    }
}
