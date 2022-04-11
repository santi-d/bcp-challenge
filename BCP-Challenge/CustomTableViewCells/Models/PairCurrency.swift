//
//  OtherCurrenciesViewModel.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import Foundation

struct PairCurrency: Codable {
    var origin: Currency
    var destination: Currency
    var changeValue: Double
    var isDefault: Bool?
}

extension PairCurrency {
    var message: String {
        "1 \(origin.rawValue.uppercased()) = \(changeValue) \(destination.rawValue.uppercased())"
    }
}

struct PairCurrencyViewModel {
    var pairCurrency: PairCurrency?
    var originAmount: Double = 0
}
