//
//  MoneyViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class ExchangeViewController: UIViewController, CurrencyDelegate {
    
    @IBOutlet weak var dateRates: UILabel!
    @IBOutlet weak var exchangeRate: UILabel!
    @IBOutlet weak var exchangeResult: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var deviseSelect: UIPickerView!
    @IBOutlet weak var euroAmount: UITextField!
    
    var chosenCurrency: takeRates?
    let calculExchange = CurrencyExchange()
    var rateDate: ExchangeJSONStructure?
    let errorController = ErrorController()
    
    var currencyExchangeRate: Double?
    var eurAmount: String?
    let todaysDate = NSDate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        calculExchange.delegate = self
        euroAmount.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        calculExchange.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        euroAmount.delegate = self
        changeCurrency(currency: .JPY)
        getCurrencyExchange()
    }
    
    func getCurrencyExchange() {
        Exchange.shared.getExchange { success, money in
            if success, let money = money {
                self.chosenCurrency = money.rates
            }
            else {
                self.errorController.presentAlertTranslate(controller: self)
            }
        }
    }
    
    @IBAction func dissmissKeyboard(_ sender: Any) {
        euroAmount.resignFirstResponder()
    }
    
    func convertCalculExchange() {
        guard let eurAmount = self.eurAmount else {return}
        guard let exchangeRate = currencyExchangeRate else {return}
        calculExchange.calculRateExchange(eurMount: eurAmount, deviseMount: exchangeRate)
    }
    
    func calculatedExchange(currencyMount: String) {
        exchangeResult.text = currencyMount
    }
}

//MARK: Extension for DateTimer Refresh
extension  ExchangeViewController {
    override func viewWillAppear(_ animated: Bool) {
        dateRates.text = "Date : \(String(Date.getCurrentDate()))"
        checkTimer()
    }
    
    func set24HrTimer() {
        let currentDate = NSDate()
        let newDate = NSDate(timeInterval: 86400, since: currentDate as Date)
        
        UserDefaults.standard.setValue(newDate, forKey: "waitingDate")
    }
    
    func checkTimer() {
        if let waitingDate:NSDate = UserDefaults.standard.value(forKey: "waitingDate") as? NSDate {
            if (todaysDate.compare(waitingDate as Date) == ComparisonResult.orderedDescending) {
                getCurrencyExchange()
                set24HrTimer()
            }
        }
    }
}


//MARK: Extension for UITextField
extension ExchangeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var realAmount = euroAmount.text! + string
        
        if string.count == 0 && range.length > 0 { //si on supprime quelque chose
            realAmount.remove(at: realAmount.index(before: realAmount.endIndex)) //retire la derniere lettre (before index = avant dernier index car le dernier est out of range)
            guard realAmount != "" else { //on regarde si il est vide ou pas
                euroAmount.text = "1" // si il est vide on rajoute quelque chose
                realAmountChange(euroAmount.text!)
                return euroAmount.text == "1"
            }
            realAmountChange(realAmount)
            convertCalculExchange()
            return true
        } else  {
            let maxAmount = 6
            let currentAmount: NSString = (realAmount) as NSString
            let newAmount: NSString = currentAmount.replacingCharacters(in: range, with: string) as NSString
            realAmountChange(realAmount)
            convertCalculExchange()
            return newAmount.length <= maxAmount
        }
    }
    
    func realAmountChange(_ realAmount: String) {
        self.eurAmount = realAmount
    }
}


//MARK: Extension for PickerView
extension ExchangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyAcronym = CurrencyAcronym(rawValue: calculExchange.takeCurrencyAcronym(currency[row]))!
        changeCurrency(currency: currencyAcronym)
    }
    
    func changeCurrency(currency: CurrencyAcronym) {
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

