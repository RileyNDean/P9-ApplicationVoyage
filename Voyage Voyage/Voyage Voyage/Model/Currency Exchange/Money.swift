//
//  Money.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation

class MoneyTrade {
    static var shared = MoneyTrade()
    private init () {}
    
    private var task: URLSessionDataTask?
    private var moneySession = URLSession(configuration: .default)
    init(moneySession: URLSession){
        self.moneySession = moneySession
    }
}

extension MoneyTrade {
    
    func getMoney(callback: @escaping (Bool,MoneyJSONStructure?) -> Void) {
        let moneyURL = moneyURLRequest()
        
        task?.cancel()
        task = moneySession.dataTask(with: moneyURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false,nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(MoneyJSONStructure.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}


extension MoneyTrade {
    private func moneyURLRequest() -> URL {
        let moneyAPI = "http://data.fixer.io/api/latest?"
        let apiKEY = "940fd92a205e34d9d783bca9312a8f07"
        let format = "1"
        let moneyURL = URL(string: "\(moneyAPI)access_key=\(apiKEY)&format=\(format)")
        return moneyURL!
    }
}
