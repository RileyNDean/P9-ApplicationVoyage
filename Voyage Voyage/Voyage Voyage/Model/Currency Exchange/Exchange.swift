//
//  Money.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation

class Exchange {
    static var shared = Exchange()
    private init () {}
    
    private var task: URLSessionDataTask?
    private var exchangeSession = URLSession(configuration: .default)
    init(exchangeSession: URLSession){
        self.exchangeSession = exchangeSession
    }
}

extension Exchange {
    
    func getExchange(callback: @escaping (Bool,ExchangeJSONStructure?) -> Void) {
        let exchangeURL = exchangeURLRequest()
        
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
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}

extension Exchange {
    private func exchangeURLRequest() -> URL {
        let moneyAPI = "http://data.fixer.io/api/latest?"
        let apiKEY = "940fd92a205e34d9d783bca9312a8f07"
        let format = "1"
        let exchangeURL = URL(string: "\(moneyAPI)access_key=\(apiKEY)&format=\(format)")
        return exchangeURL!
    }
}
