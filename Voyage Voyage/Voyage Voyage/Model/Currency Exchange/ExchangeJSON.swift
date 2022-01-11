//
//  MoneyJSON.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 08/01/2022.
//

import Foundation

struct ExchangeJSONStructure {
    let rates: takeRates?
}

extension ExchangeJSONStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case rates = "rates"
    }
}

struct takeRates {
    let JPY: Double?
    let USD: Double?
    let GBP: Double?
    let AUD: Double?
}

extension takeRates: Decodable {
    enum CodingKeys: String, CodingKey {
        case JPY = "JPY"
        case USD = "USD"
        case GBP = "GBP"
        case AUD = "AUD"
    }
}
