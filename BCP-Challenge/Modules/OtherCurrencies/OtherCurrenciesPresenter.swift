//
//  OtherCurrenciesPresenter.swift
//  BCP-Challenge
//
//  Created by Santi D on 11/04/22.
//

import Foundation

protocol OtherCurrenciesPresenterProtocol {
    var interactor: OtherCurrencyInteractorProtocol? { get set }
    var pairCurrencies: [PairCurrency] { get set }

    func refreshCurrencies(for currency: Currency)
    func getPairs(originViewModel: PairCurrency) -> PairCurrency?
}

class OtherCurrenciesPresenter: OtherCurrenciesPresenterProtocol {
    var interactor: OtherCurrencyInteractorProtocol?
    var pairCurrencies: [PairCurrency] = []

    init(interactor: OtherCurrencyInteractorProtocol) {
        self.interactor = interactor
    }

    func refreshCurrencies(for currency: Currency) {
        pairCurrencies = interactor?.refreshCurrencies(for: currency) ?? []
    }
    func getPairs(originViewModel: PairCurrency) -> PairCurrency? {
        interactor?.getPairs(originViewModel: originViewModel)
    }
}
