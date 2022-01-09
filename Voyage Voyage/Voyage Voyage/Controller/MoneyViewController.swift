//
//  MoneyViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class MoneyViewController: UIViewController, CurrencyDelegate {

    @IBOutlet weak var dateRates: UILabel!
    @IBOutlet weak var changeRate: UILabel!
    @IBOutlet weak var changeResult: UILabel!
    @IBOutlet weak var changeSymbol: UILabel!
    @IBOutlet weak var deviseSelect: UIPickerView!
    @IBOutlet weak var euroAmount: UITextField!
    var currencyChoose: takeRates?
    let calculExchange = CurrencyExchange()
    var rateDate: MoneyJSONStructure?
    var currencyRate: Double?
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
        getCurrencyChange()
    }

    @IBAction func valideExchange(_ sender: UIButton) {
        convertCalculExchange()
    }
    
    func getCurrencyChange() {
        MoneyTrade.shared.getMoney { success, money in
            if success, let money = money {
                self.currencyChoose = money.rates
            }
            else {
                print("erreur?")
            }
        }
    }
    
    @IBAction func dissmissKeyboard(_ sender: Any) {
        euroAmount.resignFirstResponder()
    }
    
    func convertCalculExchange() {
        guard let eurAmount = self.eurAmount else {return}
        guard let exchangeRate = currencyRate else {return}
        calculExchange.calculExchange(eurMount: eurAmount, deviseMount: exchangeRate)
    }
    
    func currencyCalculated(currencyMount: String) {
        changeResult.text = currencyMount
    }
}

//MARK: Extension for DateTimer Refresh
extension  MoneyViewController {
    override func viewWillAppear(_ animated: Bool) {
        dateRates.text = "Date : \(String(Date.getCurrentDate()))"
        print(todaysDate.description)
        checkTimer()
    }
    func set24HrTimer() {
        let currentDate = NSDate()
        let newDate = NSDate(timeInterval: 86400, since: currentDate as Date)

        UserDefaults.standard.setValue(newDate, forKey: "waitingDate")
        print("24 hours started")
        print(currentDate.description)
    }
    func checkTimer() {
        if let waitingDate:NSDate = UserDefaults.standard.value(forKey: "waitingDate") as? NSDate {
                if (todaysDate.compare(waitingDate as Date) == ComparisonResult.orderedDescending) {
                    getCurrencyChange()
                    set24HrTimer()
                }
            else {
                print(waitingDate.description)
            }
            }
    }
}


//MARK: Extension for UITextField
extension MoneyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var realAmount = euroAmount.text! + string
        
        if string.count == 0 && range.length > 0 {
            realAmount.remove(at: realAmount.index(before: realAmount.endIndex))
            guard realAmount != "" else {
                euroAmount.text = "1"
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
extension MoneyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        let currencyAcronym = CurrencyChange(rawValue: takeCurrencyAcronym(currency[row]))!
        changeCurrency(currency: currencyAcronym)   
    }
    
    func changeCurrency(currency: CurrencyChange) {
        switch currency {
        case .JPY:
            changeSymbol.text = "¥"
            guard let JPY = currencyChoose?.JPY! else {return}
            changeRate.text = "Exchange rate : \(String(describing: JPY))"
            self.currencyRate = currencyChoose?.JPY!
            convertCalculExchange()
        case .USD:
            changeSymbol.text = "$"
            guard let USD = currencyChoose?.USD! else {return}
            changeRate.text = "Exchange rate : \(String(describing: USD))"
            self.currencyRate = currencyChoose?.USD!
            convertCalculExchange()
        case .GBP:
            changeSymbol.text = "£"
            guard let GBP = currencyChoose?.GBP! else {return}
            changeRate.text = "Exchange rate : \(String(describing: GBP))"
            self.currencyRate = currencyChoose?.GBP!
            convertCalculExchange()
        case .AUD:
            changeSymbol.text = "$"
            guard let AUD = currencyChoose?.AUD! else {return}
            changeRate.text = "Exchange rate : \(String(describing: AUD))"
            self.currencyRate = currencyChoose?.AUD!
            convertCalculExchange()
        }
    }
    
    func takeCurrencyAcronym(_ currency: String) -> String {
        let currencyCut = currency.cutString
        let currencyAcronym = currencyCut.last!
        return String(currencyAcronym)
    }
}


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "EEEE d MMM  yyyy"

        return dateFormatter.string(from: Date())

    }
}
