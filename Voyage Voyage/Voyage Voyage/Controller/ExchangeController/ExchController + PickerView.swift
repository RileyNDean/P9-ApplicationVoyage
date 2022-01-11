//
//  ExchController + PickerView.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: Extension for PickerView
extension ExchangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calculExchange.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calculExchange.currency[row]
    }
    
    //when pickerview is moved do action
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyAcronym = CurrencyAcronym(rawValue: calculExchange.takeCurrencyAcronym(chosenCurrency!.currency[row]))! //take currency Acronym of the picker view
        changeCurrency(currency: currencyAcronym) //change the currency
    }
    
    private func changeCurrency(currency: CurrencyAcronym) {
        switch currency {
        case .JPY:
            currencySymbol.text = "¥"
            guard let JPY = chosenCurrency?.JPY! else {return}
            exchangeRate.text = "Exchange rate : \(String(describing: JPY))"
            self.currencyExchangeRate = chosenCurrency?.JPY!
            convertCalculExchange()
        case .USD:
            currencySymbol.text = "$"
            guard let USD = chosenCurrency?.USD! else {return}
            exchangeRate.text = "Exchange rate : \(String(describing: USD))"
            self.currencyExchangeRate = chosenCurrency?.USD!
            convertCalculExchange()
        case .GBP:
            currencySymbol.text = "£"
            guard let GBP = chosenCurrency?.GBP! else {return}
            exchangeRate.text = "Exchange rate : \(String(describing: GBP))"
            self.currencyExchangeRate = chosenCurrency?.GBP!
            convertCalculExchange()
        case .AUD:
            currencySymbol.text = "$"
            guard let AUD = chosenCurrency?.AUD! else {return}
            exchangeRate.text = "Exchange rate : \(String(describing: AUD))"
            self.currencyExchangeRate = chosenCurrency?.AUD!
            convertCalculExchange()
        }
    }
}
