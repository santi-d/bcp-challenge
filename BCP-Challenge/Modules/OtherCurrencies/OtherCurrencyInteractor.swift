//
//  ChangeCurrencyInteractor.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import Foundation

protocol OtherCurrencyInteractorProtocol: BaseInteractorProtocol {
    var pairCurrencies: [PairCurrency] { get set }

    func refreshCurrencies(for currency: Currency)
    func getPairs(originViewModel: PairCurrency) -> PairCurrency?
}

class OtherCurrencyInteractor: OtherCurrencyInteractorProtocol {
    private var allPairCurrencies: [PairCurrency] = []
    var pairCurrencies: [PairCurrency] = []

    func refreshCurrencies(for currency: Currency) {
        guard let jsonData = readLocalJSONFile(name: "currencies") else {
            return
        }

        allPairCurrencies = parse(jsonData: jsonData)

        let currenciesParsed = allPairCurrencies
            .filter {
                $0.origin == currency
            }

        pairCurrencies = currenciesParsed
    }

    func getPairs(originViewModel: PairCurrency) -> PairCurrency? {
        allPairCurrencies.filter {
            $0.origin == originViewModel.destination && $0.destination == originViewModel.origin
        }.first
    }
}
