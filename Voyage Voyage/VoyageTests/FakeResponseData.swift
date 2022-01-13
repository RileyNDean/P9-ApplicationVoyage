//
//  FakeResponseData.swift
//  VoyageTests
//
//  Created by Dhayan Bourguignon on 12/01/2022.
//

import Foundation

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
 
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let weatherIncorrectData = "error".data(using: .utf8)!
    
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let exchangeIncorrectData = "error".data(using: .utf8)!
    
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let translateIncorrectData = "error".data(using: .utf8)!
    
    class APIError: Error {}
    static let error = APIError()
}


