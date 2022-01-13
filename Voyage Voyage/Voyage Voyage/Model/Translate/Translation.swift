//
//  Translation.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

class Translation {
    weak var delegate: TranslateDelegate?
    var langs = ["English - EN", "Russian - RU", "French - FR", "Japanese - JA"]
    var langAcronym = ""
    
    func getBaseLang(_ lang: String) {
        let langCut = lang.cutString
        let baseLang = langCut.first!
        self.langAcronym = String(baseLang.uppercased())
        let langageDetected = "Langage Detected: " + self.langAcronym
        delegate?.baseLangageDelegate(langageDetected)
    }
    
    func getDestinationLang(_ lang: String) -> String {
        let langCut = lang.cutString
        let baseLang = langCut.last!
        self.langAcronym = String(baseLang.uppercased()) //upcase the acronym
        return self.langAcronym
    }
    
    func getDestinationLangTranslate(_ lang: String) {
        let langCut = lang.cutString
        let baseLang = langCut.last!
        self.langAcronym = String(baseLang.lowercased()) //lowercase the acronym
        Translate.destinationLanguage = self.langAcronym
    }
    
    func getTranslatedText(_ text: [String]) {
        let newText = text[0]
        delegate?.translatedTextView(newText)
    }
    
    func modifyText(_ text: String) {
        Translate.translatedText = text.withReplacedCharacters(" ", by: "%20")
    }
}

protocol TranslateDelegate: NSObject {
    func baseLangageDelegate(_ lang: String)
    func translatedTextView(_ text: String)
}
