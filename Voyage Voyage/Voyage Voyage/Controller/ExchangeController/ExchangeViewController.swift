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
    
    var chosenCurrency: ExchangeData?
    let calculExchange = CurrencyExchange()
    let errorController = ErrorController()
    
    var currencyExchangeRate: Double?
    
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
        getCurrencyExchange()
    }
    
    func getCurrencyExchange() {
        Exchange.shared.getExchange { success, money in
            if success, let money = money {
                self.chosenCurrency = money
                self.dateRates.text = "Date : \(String(Date.getCurrentDate()))"
            }
            else {
                self.errorController.presentAlertTranslate(controller: self)
            }
        }
    }
    
    @IBAction func dissmissKeyboard(_ sender: Any) {
        euroAmount.resignFirstResponder()
    }
    
    func convertCalculExchange(_ euroAmount: String) {
        guard let exchangeRate = currencyExchangeRate else {return}
        calculExchange.calculRateExchange(eurMount: euroAmount, deviseMount: exchangeRate)
    }
    
    func calculatedExchange(currencyMount: String) {
        exchangeResult.text = currencyMount
    }
}







