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
    var currencyRate: Double?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        testmONEY()
        calculExchange.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        testmONEY()
        calculExchange.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        testmONEY()
        changeCurrency(currency: .JPY)
    }

    @IBAction func valideExchange(_ sender: UIButton) {
        convertCalculExchange()
    }
    
    func testmONEY() {
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
        guard let eurAmount = euroAmount.text else {return}
        guard let exchangeRate = currencyRate else {return}
        calculExchange.calculExchange(eurMount: eurAmount, deviseMount: exchangeRate)
    }
    
    func currencyCalculated(currencyMount: String) {
        changeResult.text = currencyMount
    }
}



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


