//
//  ChangeCurrencyInteractor.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import Foundation

protocol OtherCurrencyInteractorProtocol: BaseInteractorProtocol {
    func refreshCurrencies(for currency: Currency) -> [PairCurrency]
    func getPairs(originViewModel: PairCurrency) -> PairCurrency?
}

class OtherCurrencyInteractor: OtherCurrencyInteractorProtocol {
    private var allPairCurrencies: [PairCurrency] = []
    private var pairCurrencies: [PairCurrency] = []

    func refreshCurrencies(for currency: Currency) -> [PairCurrency] {
        guard let jsonData = readLocalJSONFile(name: "currencies") else {
            return []
        }

        allPairCurrencies = parse(jsonData: jsonData)

        let currenciesParsed = allPairCurrencies
            .filter {
                $0.origin == currency
            }

        pairCurrencies = currenciesParsed

        return pairCurrencies
    }

    func getPairs(originViewModel: PairCurrency) -> PairCurrency? {
        allPairCurrencies.filter {
            $0.origin == originViewModel.destination && $0.destination == originViewModel.origin
        }.first
    }
}
