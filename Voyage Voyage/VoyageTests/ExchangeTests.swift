//
//  VoyageTests.swift
//  VoyageTests
//
//  Created by Dhayan Bourguignon on 12/01/2022.
//

import XCTest
@testable import Voyage_Voyage

class ExchangeTests: XCTestCase {
    
    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }

    func testGetExchangeShouldPostfailedCallbackIfNoData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = Exchange(exchangeSession: session)
        // When
        let expectation = XCTestExpectation(description: "wait for queu change.")
        exchangeService.getExchange { success, weatherResult in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetExchangeShouldPostFailedCallbackIfError() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let data: Data? = nil
            let error: Error? = FakeResponseData.error
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = Exchange(exchangeSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeService.getExchange { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetExchangeShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let data: Data? = FakeResponseData.exchangeCorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = Exchange(exchangeSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeService.getExchange { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetExchangeShouldPostFailedCallbackIfIncorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.exchangeIncorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = Exchange(exchangeSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeService.getExchange { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetExchangeShouldPostSuccessCallbackIfNoErrrorAndCorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.exchangeCorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = Exchange(exchangeSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeService.getExchange { success, exchange in
            //Then
            let USD = 4.191435
            let JPY = 119.8457
            let GBP = 122.356194
            let AUD = 549.436484
            
            XCTAssertTrue(success)
            XCTAssertNotNil(exchange)
            
            XCTAssertEqual(USD, exchange!.USD)
            XCTAssertEqual(JPY, exchange!.JPY)
            XCTAssertEqual(GBP, exchange!.GBP)
            XCTAssertEqual(AUD, exchange!.AUD)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testCalculRateExchangeWhenStringAmountAndDoubleAmountThenGiveMultiplicationOfTheTwoNumber() {
        let currency = CurrencyExchange()
        currency.calculRateExchange(eurMount: "3", deviseMount: 2.75)
        let equalMultiplication = currency.exchangeRateCalculate
        XCTAssertEqual(equalMultiplication, "8.25")
    }
    
    func testTakeCurrencyAcronymWhenTwoAcronymStuckThenGiveTheLast() {
        let currency = CurrencyExchange()
        let acronym = currency.takeCurrencyAcronym("Japan - JPY")
        XCTAssertEqual(acronym, "JPY")
    }
    
    func testUpdateRefreshDateWhenGiveADateThen24HoursLater() {
        let currency = CurrencyExchange()
        let currentDate = NSDate()
        currency.updateRefreshDate()
        let lastRefreshDate: NSDate = UserDefaults.standard.value(forKey: "waitingDate") as! NSDate
        
        XCTAssertNotEqual(currentDate, lastRefreshDate)
        
    }
}
