//
//  BaseInteractorProtocol.swift
//  BCP-Challenge
//
//  Created by Santi D on 11/04/22.
//

import Foundation

protocol BaseInteractorProtocol {}

extension BaseInteractorProtocol {
    func readLocalJSONFile(name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }

    func parse(jsonData: Data) -> [PairCurrency] {
        do {
            let decodedData = try JSONDecoder().decode([PairCurrency].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }

        return []
    }
}
