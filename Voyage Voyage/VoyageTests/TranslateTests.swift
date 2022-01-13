//
//  VoyageTests.swift
//  VoyageTests
//
//  Created by Dhayan Bourguignon on 12/01/2022.
//

import XCTest
@testable import Voyage_Voyage

class TranslateTests: XCTestCase {
    
    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }

    func testGetTranslateShouldPostfailedCallbackIfNoData() {
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
        let translateService = Translate(translatedTextSession: session)
        // When
        let expectation = XCTestExpectation(description: "wait for queu change.")
        translateService.getTranslatedText { success, translate in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
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
        let translateService = Translate(translatedTextSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        translateService.getTranslatedText { success, translate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
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
        let translateService = Translate(translatedTextSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        translateService.getTranslatedText { success, translate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
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
        let translateService = Translate(translatedTextSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        translateService.getTranslatedText { success, translate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetTranslateShouldPostSuccessCallbackIfNoErrrorAndCorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.translateCorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translateService = Translate(translatedTextSession: session)
        //When
        let expectation = XCTestExpectation(description: "wait for queu change")
        translateService.getTranslatedText { success, translate in
            //Then
            let lang = "fr-en"
            let text = ["I like chocolate"]
            
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            
            XCTAssertEqual(text, translate!.text)
            XCTAssertEqual(lang, translate!.lang)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testModifyTextWhenStringWithSpaceThenReplaceSpaceWithPercent20() {
        let translation = Translation()
        translation.modifyText("I like Chocolate")
        let textModifier = Translate.translatedText
        XCTAssertEqual(textModifier, "I%20like%20Chocolate")
    }
    
    func testGetDestinationLangTranslateShouldCutStringAndGiveLastWordLowercased() {
        let translation = Translation()
        translation.getDestinationLangTranslate("English - EN")
        let langAcronym = translation.langAcronym
        XCTAssertEqual(langAcronym, "en")
    }
    
    func testGetDestinationLangShouldCutStringAndGiveLastWordUppercased() {
        let translation = Translation()
        let langAcronym = translation.getDestinationLang("English - en")
        XCTAssertEqual(langAcronym, "EN")
    }
    
    func testGetBaseLangShouldCutStringAndGiveFirstWordUppercased() {
        let translation = Translation()
        translation.getBaseLang("fr-en")
        let langAcronym = translation.langAcronym
        XCTAssertEqual(langAcronym, "FR")
    }

}
