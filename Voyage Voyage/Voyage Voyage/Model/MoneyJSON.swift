//
//  MoneyJSON.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 08/01/2022.
//

import Foundation

struct MoneyJSONStructure {
    let date: String?
    let base: String?
    let rates: takeRates?
}

extension MoneyJSONStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case base = "base"
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
