//
//  Currency.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 09/01/2022.
//

import Foundation

enum CurrencyAcronym: String {
    case JPY,USD,GBP,AUD
}

class CurrencyExchange {
    
    weak var delegate: CurrencyDelegate?
    var exchangeRateCalculate: String = ""
    let currency = ["Japan - JPY",
    "United States -  USD",
    "United Kingdoms - GBP",
    "Austral - AUD"]
    
    func calculRateExchange(eurMount: String, deviseMount: Double) {
        let amount = Double(eurMount)!
        let change = amount * Double(round(100 * deviseMount)/100) //Multiply the double to round 10^(the number of decimal place) for ggain 2number after the .
        exchangeRateCalculate = String(format: "%.2f", change) //print 2 characters after the .
        delegate?.calculatedExchange(currencyMount: exchangeRateCalculate)
    }
    
    func takeCurrencyAcronym(_ currency: String) -> String { // cut string for acronym
        let currencyCut = currency.cutString
        let currencyAcronym = currencyCut.last!
        return String(currencyAcronym)
    }
    
    func updateRefreshDate() {
        let currentDate = NSDate()
        let newDate = NSDate(timeInterval: 86400, since: currentDate as Date) //one day timer
        UserDefaults.standard.setValue(newDate, forKey: "waitingDate") //timer key
    }
    
}

protocol CurrencyDelegate: NSObject {
    func calculatedExchange(currencyMount: String)
}
