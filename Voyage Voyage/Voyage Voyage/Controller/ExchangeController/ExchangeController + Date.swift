//
//  ExchangeController + Date.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: Extension for DateTimer Refresh
extension  ExchangeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateExchangeRateIfNeeded()
    }
    
    private func updateExchangeRateIfNeeded() {
        if let lastRefreshDate: NSDate = UserDefaults.standard.value(forKey: "waitingDate") as? NSDate
            , NSDate().compare(lastRefreshDate as Date) == ComparisonResult.orderedDescending {
            getCurrencyExchange()
            calculExchange.updateRefreshDate()
        }
    }
}
