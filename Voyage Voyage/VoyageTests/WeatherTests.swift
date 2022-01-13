//
//  VoyageTests.swift
//  VoyageTests
//
//  Created by Dhayan Bourguignon on 12/01/2022.
//

import XCTest
@testable import Voyage_Voyage

class WeatherTests: XCTestCase {
    
    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }

    func testGetWeatherShouldPostfailedCallbackIfNoData() {
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
        let weatherService = Weather(weatherSession: session)
        // When
        let expectation = XCTestExpectation(description: "wait for queu change.")
        weatherService.getWeather { success, weatherResult in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
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
        let weatherService = Weather(weatherSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        weatherService.getWeather { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let data: Data? = FakeResponseData.weatherCorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = Weather(weatherSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        weatherService.getWeather { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.weatherIncorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = Weather(weatherSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        weatherService.getWeather { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrrorAndCorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.weatherCorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = Weather(weatherSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        weatherService.getWeather { success, weather in
            //Then
            let icon = "03d"
            let temp: Float = -1.07
            let description = "scattered clouds"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            XCTAssertEqual(icon, weather!.icon)
            XCTAssertEqual(temp, weather!.temp)
            XCTAssertEqual(description, weather!.description)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }


}
