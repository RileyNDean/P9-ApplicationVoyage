//
//  Money.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation

class Exchange {
    static var shared = Exchange()
    private init () {
        self.exchangeSession = URLSession(configuration: .default)
    }
    
    private var task: URLSessionDataTask?
    private var exchangeSession: URLSession
    
    init(exchangeSession: URLSession){
        self.exchangeSession = exchangeSession
    }
    
}

//MARK: Extension for the request
extension Exchange {
    
    func getExchange(callback: @escaping (Bool,ExchangeData?) -> Void) {

        let exchangeURL = exchangeURL()
        
        task?.cancel()
        task = exchangeSession.dataTask(with: exchangeURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false,nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ExchangeJSONStructure.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let USD = responseJSON.rates?.USD
                let JPY = responseJSON.rates?.JPY
                let GBP = responseJSON.rates?.GBP
                let AUD = responseJSON.rates?.AUD
                
                callback(true, ExchangeData(JPY: JPY, USD: USD, GBP: GBP, AUD: AUD))
            }
        }
        task?.resume()
    }
    
    private func exchangeURL() -> URL {
        let moneyAPI = "http://data.fixer.io/api/latest?"
        let apiKEY = "d5bfb3f54ac76483f0fea9a8bf034578"
        let format = "1"
        let exchangeURL = URL(string: "\(moneyAPI)access_key=\(apiKEY)&format=\(format)")
        return exchangeURL!
    }
}
