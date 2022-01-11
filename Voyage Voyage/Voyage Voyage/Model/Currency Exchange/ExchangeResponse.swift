//
//  MoneyJSON.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 08/01/2022.
//

import Foundation

struct ExchangeData {
    
    var JPY: Double?
    var USD: Double?
    var GBP: Double?
    var AUD: Double?
    
    let currency = ["Japan - JPY",
    "United States -  USD",
    "United Kingdoms - GBP",
    "Austral - AUD"]
}

struct ExchangeJSONStructure {
    let rates: TakeRates?
}

extension ExchangeJSONStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case rates = "rates"
    }
}

struct TakeRates {
    let JPY: Double?
    let USD: Double?
    let GBP: Double?
    let AUD: Double?
}

extension TakeRates: Decodable {
    enum CodingKeys: String, CodingKey {
        case JPY = "JPY"
        case USD = "USD"
        case GBP = "GBP"
        case AUD = "AUD"
    }
}
