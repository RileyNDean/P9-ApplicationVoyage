//
//  Currency.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 09/01/2022.
//

import Foundation

let currency = ["Japan - JPY",
"United States -  USD",
"United Kingdoms - GBP",
"Austral - AUD"]

enum CurrencyChange: String {
    case JPY,USD,GBP,AUD
}

class CurrencyExchange {
    
    weak var delegate: CurrencyDelegate?
    var exchangeCalculate: String = ""
    
    func calculExchange(eurMount: String, deviseMount: Double) {
        let amount = Double(eurMount)!
        let change = amount * Double(round(100 * deviseMount)/100) //Multiply the double to round 10^(the number of decimal place)
        exchangeCalculate = String(change)
        delegate?.currencyCalculated(currencyMount: exchangeCalculate)
    }
}

protocol CurrencyDelegate: NSObject {
    func currencyCalculated(currencyMount: String)
}
