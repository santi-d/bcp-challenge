//
//  CurrencyChangeViewModel.swift
//  BCP-Challenge
//
//  Created by Santi D on 10/04/22.
//

import Foundation

enum Currency: String, Codable {
    case pen
    case usd
    case eur

    var country: String {
        switch self {
            case .pen:
                return "Perú"
            case .usd:
                return "United States"
            case .eur:
                return "European Union"
        }
    }

    var value: String {
        switch self {
            case .pen:
                return "Soles"
            case .usd:
                return "Dólares"
            case .eur:
                return "Euros"
        }
    }
}
