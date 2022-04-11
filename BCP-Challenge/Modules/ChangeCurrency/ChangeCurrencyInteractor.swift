//
//  ChangeCurrencyInteractor.swift
//  BCP-Challenge
//
//  Created by Santi D on 11/04/22.
//

import Foundation

protocol ChangeCurrencyInteractorProtocol: BaseInteractorProtocol {
    func fetchDefaultPairCurrency() -> PairCurrency?
    func getReversePairCurrency(from pairCurrency: PairCurrency) -> PairCurrency?
}

class ChangeCurrencyInteractor: ChangeCurrencyInteractorProtocol {
    func fetchDefaultPairCurrency() -> PairCurrency? {
        guard let jsonData = readLocalJSONFile(name: "currencies") else {
            return nil
        }

        return parse(jsonData: jsonData)
            .filter { $0.isDefault == true }
            .first
    }

    func getReversePairCurrency(from pairCurrency: PairCurrency) -> PairCurrency? {
        guard let jsonData = readLocalJSONFile(name: "currencies") else {
            return nil
        }

        return parse(jsonData: jsonData)
            .filter { $0.origin == pairCurrency.destination && $0.destination == pairCurrency.origin }
            .first
    }
}
